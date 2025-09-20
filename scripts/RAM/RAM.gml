function RAM() constructor  {
    memory = buffer_create(2048, buffer_fixed, 1);
    
    static write = function(_value, _address, _signed) {
        buffer_seek(memory, buffer_seek_start, _address);
        buffer_write(memory, _signed ? buffer_s8 : buffer_u8, _value);
    }
    
    static read = function(_address, _signed) {
        buffer_seek(memory, buffer_seek_start, _address);
        return buffer_read(memory, _signed ? buffer_s8 : buffer_u8);
    }
}

