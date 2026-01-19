if (instance_number(object_index) > 1) {
    instance_destroy();
    exit;
}

memory_used = debug_event("DumpMemory");

rom = buffer_load("smb.nes");
ram = new NES_RAM();

buffer_seek(rom, buffer_seek_start, 0);

var ines_header = "";
repeat (4) {
    ines_header += chr(buffer_read(rom, buffer_u8));
}

if (ines_header != "NES") {
    show_message("Invalid rom file. GMES only supports iNES rom files (so far)!");
    game_end();
}

var ps = buffer_read(rom, buffer_u8);
program = {
    size: kilobyte_units(16, ps),
    data: buffer_create(ps, buffer_fast, 1)
}

var cs = buffer_read(rom, buffer_u8);
chr_rom = {
    size: kilobyte_units(8, cs),
    data: buffer_create(cs, buffer_fast, 1)
}

rom_flags = array_create(5);
for (var i = 0; i < 5; i++) {
    rom_flags[i] = buffer_read(rom, buffer_u8);
}

get_rom_flags = function(num) {
    return rom_flags[num - 6];
}

//skips over useless padding
repeat (4) {
    buffer_read(rom, buffer_u8);
}

buffer_copy(rom, buffer_tell(rom), program.size, program.data, 0);
buffer_seek(rom, buffer_seek_relative, program.size);

buffer_copy(rom, buffer_tell(rom), chr_rom.size, chr_rom.data, 0);
buffer_seek(rom, buffer_seek_relative, chr_rom.size);

global.__register = {
    A: 0,
    X: 0,
    Y: 0,
    C: 0,
    PC: 0,
    SP: 0,
    SR: 0
}
#macro REGISTER global.__register

flags = 0;

// i fucking hate this so much
OPCODES = array_create(256, function() {});

OPCODE_INIT();

enum RegisterFlag {
    Carry = 1,
    Zero = 2,
    Interrupt = 4,
    Decimal = 8,
    Break = 16,
    None = 32,
    Overflow = 64,
    Negative = 128
}

buffer_seek(program.data, buffer_seek_start, 0);

mem_info = {
    address: 0,
    data: 0,
}
read_from_program = function() {
    mem_info = {
        address: buffer_tell(program.data),
        data: buffer_read(program.data, buffer_u8),
    }
    buffer_seek(program.data, buffer_seek_relative, 1);
    return mem_info.data;
}
