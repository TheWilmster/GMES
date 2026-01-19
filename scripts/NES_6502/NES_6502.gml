#region Instruction Set

function NES_InstrADC(value) {
    var result = REGISTER.A + value + REGISTER.C;
    flags |= (result > $FF) & RegisterFlag.Carry
    flags |= (result == 0) & RegisterFlag.Zero;
    flags |= ((result ^ REGISTER.A) & (result ^ value) & $80) & RegisterFlag.Overflow;
    flags |= result & RegisterFlag.Negative;
    REGISTER.A = result;
    return result;
}
function NES_InstrAND(value) {
    var result = REGISTER.A & value;
    flags |= (result == 0) & RegisterFlag.Zero;
    flags |= result & RegisterFlag.Negative;
    REGISTER.A = result;
    return result;
}
function NES_InstrASL(value) {
    var result = value << 1;
    flags |= value & RegisterFlag.Negative;
    flags |= result == 0
    flags |= result & RegisterFlag.Negative;
    return result;
}
function NES_InstrBCC(value) {
    var result = REGISTER.PC;
    if (!(flags & RegisterFlag.Carry)) {
        result += 2 + (value - 256);
    }
    REGISTER.PC = result;
    return result;
}
function NES_InstrBCS(value) {
    var result = REGISTER.PC;
    if (flags & RegisterFlag.Carry) {
        result += 2 + (value - 256);
    }
    REGISTER.PC = result;
    return result;
}
function NES_InstrBEQ(value) {
    var result = REGISTER.PC;
    if (flags & RegisterFlag.Zero) {
        result += 2 + (value - 256);
    }
    REGISTER.PC = result;
    return result;
}
function NES_InstrBIT(value) {
    var result = REGISTER.A & value;
    flags |= (result == 0) & RegisterFlag.Zero;
    flags |= result & RegisterFlag.Overflow;
    flags |= result & RegisterFlag.Negative;
}
function NES_InstrBMI(value) {
    var result = REGISTER.PC;
    if (flags & RegisterFlag.Negative) {
        result += 2 + (value - 256);
    }
    REGISTER.PC = result;
    return result;
}
function NES_InstrBNE(value) {
    var result = REGISTER.PC;
    if (!(flags & RegisterFlag.Zero)) {
        result += 2 + (value - 256);
    }
    REGISTER.PC = result;
    return result;
}
function NES_InstrBPL(value) {
    var result = REGISTER.PC;
    if (!(flags & RegisterFlag.Negative)) {
        result += 2 + (value - 256);
    }
    REGISTER.PC = result;
    return result;
}
function NES_InstrBRK(value) {
    //todo: implement this LMAO not doing this shit right now
}
function NES_InstrBVC(value) {
    var result = REGISTER.PC + 2 + (value - 256);
    if (!(flags & RegisterFlag.Overflow)) {
        result += 2 + (value - 256);
    }
    REGISTER.PC = result;
    return result;
}
function NES_InstrBVS(value) {
    var result = REGISTER.PC + 2 + (value - 256);
    if !(flags & RegisterFlag.Overflow) {
        result += 2 + (value - 256);
    }
    REGISTER.PC = result;
    return result;
}
function NES_InstrCLC(value) {
    flags |= 0 & RegisterFlag.Carry;
}
function NES_InstrCLD(value) {
    flags |= 0 & RegisterFlag.Decimal;
}
function NES_InstrCLI(value) {
    flags |= 0 & RegisterFlag.Interrupt;
}
function NES_InstrCLV(value) {
    flags |= 0 & RegisterFlag.Overflow;
}
function NES_InstrCMP(value) {
    var result = REGISTER.A - value;
    flags |= (REGISTER.A >= value) & RegisterFlag.Carry;
    flags |= (REGISTER.A == value) & RegisterFlag.Zero;
    flags |= result & RegisterFlag.Negative;
}
function NES_InstrCPX(value) {
    var result = REGISTER.X - value;
    flags |= (REGISTER.X >= value) & RegisterFlag.Carry;
    flags |= (REGISTER.X == value) & RegisterFlag.Zero;
    flags |= result & RegisterFlag.Negative;
}
function NES_InstrCPY(value) {
    var result = REGISTER.Y - value;
    flags |= (REGISTER.Y >= value) & RegisterFlag.Carry;
    flags |= (REGISTER.Y == value) & RegisterFlag.Zero;
    flags |= result & RegisterFlag.Negative;
}
function NES_InstrDEC(value) {
    var result = value - 1;
    flags |= (result == 0) & RegisterFlag.Zero;
    flags |= result & RegisterFlag.Negative;
    return result;
}
function NES_InstrDEX(value) {
    var result = REGISTER.X - 1;
    flags |= (result == 0) & RegisterFlag.Zero;
    flags |= result & RegisterFlag.Negative;
    REGISTER.X = result;
    return result;
}
function NES_InstrDEY(value) {
    var result = REGISTER.Y - 1;
    flags |= (result == 0) & RegisterFlag.Zero;
    flags |= result & RegisterFlag.Negative;
    REGISTER.Y = result;
    return result;
}
function NES_InstrEOR(value) {
    var result = REGISTER.A ^ value;
    flags |= (result == 0) & RegisterFlag.Zero;
    flags |= result & RegisterFlag.Negative;
    REGISTER.A = result;
    return result;
}
function NES_InstrINC(value) {
    var result = value + 1;
    flags |= (result == 0) & RegisterFlag.Zero;
    flags |= result & RegisterFlag.Negative;
    return result;
}
function NES_InstrINX(value) {
    var result = REGISTER.X + 1;
    flags |= (result == 0) & RegisterFlag.Zero;
    flags |= result & RegisterFlag.Negative;
    REGISTER.X = result;
    return result;
}
function NES_InstrINY(value) {
    var result = REGISTER.Y + 1;
    flags |= (result == 0) & RegisterFlag.Zero;
    flags |= result & RegisterFlag.Negative;
    REGISTER.Y = result;
    return result;
}
function NES_InstrJMP(value) {
    REGISTER.PC = value;
}
function NES_InstrJSR(value) {
    // push PC + 2 high byte to stack
    // push PC + 2 low byte to stack
    REGISTER.PC = value;
}
function NES_InstrLDA(value) {
    REGISTER.A = value;
    flags |= (REGISTER.A == 0) & RegisterFlag.Zero;
    flags |= REGISTER.A & RegisterFlag.Negative;
}
function NES_InstrLDX(value) {
    REGISTER.X = value;
    flags |= (REGISTER.X == 0) & RegisterFlag.Zero;
    flags |= REGISTER.X & RegisterFlag.Negative;
}
function NES_InstrLDY(value) {
    REGISTER.Y = value;
    flags |= (REGISTER.Y == 0) & RegisterFlag.Zero;
    flags |= REGISTER.Y & RegisterFlag.Negative;
}
function NES_InstrLSR(value) {
    var result = value >> 1;
    flags |= value & RegisterFlag.Carry;
    flags |= (result == 0) & RegisterFlag.Zero;
    flags |= 0 & RegisterFlag.Negative;
}
function NES_InstrNOP(value) {
    // this one doesnt even do anything why the hell did they add it
    // timed code or some bullshit?? who tf knows
}
function NES_InstrORA(value) {
    var result = REGISTER.A | value;
    flags |= (result == 0) & RegisterFlag.Zero;
    flags |= result & RegisterFlag.Negative;
    REGISTER.A = result;
    return result;
}
function NES_InstrPHA(value) {
    var result = ($0100 + REGISTER.SP--);
    REGISTER.A = result;
    return result;
}
function NES_InstrPHP(value) {
    var result = ($0100 + REGISTER.SP--);
    var old_flags = flags;
    flags = result;
    flags |= old_flags & RegisterFlag.Break;
    return result;
}
function NES_InstrPLA(value) {
    REGISTER.A = ($0100 + ++REGISTER.SP);
    flags |= (REGISTER.A == 0) & RegisterFlag.Zero;
    flags |= REGISTER.A & RegisterFlag.Negative;
}
function NES_InstrPLP(value) {
    var result = ($0100 + REGISTER.SP++);
    var old_flags = flags;
    flags = result;
    flags |= old_flags & RegisterFlag.Break;
}
function NES_InstrROL(value) {
    var result = value << 1;
    flags |= (value & RegisterFlag.Negative) & RegisterFlag.Carry;
    flags |= (value == 0) & RegisterFlag.Zero;
    flags |= value & RegisterFlag.Negative;
    return result;
}
function NES_InstrROR(value) {
    var result = value >> 1;
    flags |= (value & RegisterFlag.Negative) & RegisterFlag.Carry;
    flags |= (value == 0) & RegisterFlag.Zero;
    flags |= value & RegisterFlag.Negative;
    return result;
}
function NES_InstrRTI(value) {
    //todo: implement this LMAO not doing this shit right now
}
function NES_InstrRTS(value) {
    //todo: implement this LMAO not doing this shit right now
}
function NES_InstrSBC(value) {
    var result = REGISTER.A - value - ~C;
    flags |= ~(result < $00) & RegisterFlag.Carry;
    flags |= (result == 0) & RegisterFlag.Zero;
    flags |= ((result ^ REGISTER.A) & (result ^ ~value) & $80) & RegisterFlag.Overflow;
    flags |= result & RegisterFlag.Negative;
    return result;
}
function NES_InstrSEC(value) {
    flags |= 1 & RegisterFlag.Carry;
}
function NES_InstrSED(value) {
    flags |= 1 & RegisterFlag.Decimal;
}
function NES_InstrSEI(value) {
    flags |= 1 & RegisterFlag.Interrupt;
}
function NES_InstrSTA(value) {
    return REGISTER.A;
}
function NES_InstrSTX(value) {
    return REGISTER.X;
}
function NES_InstrSTY(value) {
    return REGISTER.Y;
}
function NES_InstrTAX(value) {
    REGISTER.X = REGISTER.A;
    flags |= (REGISTER.A == 0) & RegisterFlag.Zero;
    flags |= REGISTER.A & RegisterFlag.Negative;
}
function NES_InstrTAY(value) {
    REGISTER.Y = REGISTER.A;
    flags |= (REGISTER.A == 0) & RegisterFlag.Zero;
    flags |= REGISTER.A & RegisterFlag.Negative;
}
function NES_InstrTSX(value) {
    REGISTER.X = REGISTER.SP;
    flags |= (REGISTER.SP == 0) & RegisterFlag.Zero;
    flags |= REGISTER.SP & RegisterFlag.Negative;
}
function NES_InstrTXA(value) {
    REGISTER.A = REGISTER.X;
    flags |= (REGISTER.X == 0) & RegisterFlag.Zero;
    flags |= REGISTER.X & RegisterFlag.Negative;
}
function NES_InstrTXS(value) {
    REGISTER.SP = REGISTER.X;
}
function NES_InstrTYA(value) {
    REGISTER.A = REGISTER.Y;
}

#endregion

#region Opcodes

function OPCODE_INIT() {
    OPCODES[($00)] = 
}

#endregion

#endregion
