if (instance_number(object_index) > 1) {
    instance_destroy();
    exit;
}

memoryAccess = new RAM();

global.__register = {
    A: 0,
    X: 0,
    Y: 0,
    C: 0
}
#macro REGISTER global.__register

flags = 0;

// i fucking hate this so much
OPCODE = 0;
OPCODE[255] = 0;

// ADC - Add Memory to Accumulator with Carry

OPCODE[($69)] = function(value) {
    var result = REGISTER.A + value + REGISTER.C;
    flags |= (result > $FF) & Flag.Carry
    flags |= (result == 0) & Flag.Zero;
    flags |= (result ^ REGISTER.A) & (result ^ value) & $80;
    flags |= result & Flag.Negative;
    REGISTER.A = result;
}
OPCODE[($65)] = function() {
    
}

enum Flag {
    Carry = 1,
    Zero = 2,
    Interrupt = 4,
    Decimal = 8,
    Break = 16,
    None = 32,
    Overflow = 64,
    Negative = 128
}
