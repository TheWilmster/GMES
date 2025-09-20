draw_set_font(fnt_8bit);
for (var i = 0; i < buffer_get_size(memoryAccess.memory); i++) {
    draw_text(2, 2 + (i * 12), string(memoryAccess.read(i, false)));
}
for (var i = 0; i < struct_names_count(register); i++) {
    var _name = struct_get_names(register)[i];
    draw_text(34, 2 + (i * 12), register[$ _name]);
}
for (var i = 0; i < 8; i++) {
    var _bits = [00000001, 00000010, 00000100, 00001000, 00010000, 00100000, 01000000, 10000000];
    draw_text(66, 2 + (i * 12), (flags & _bits[i]) != 0);
    flags = 00100000;
}
