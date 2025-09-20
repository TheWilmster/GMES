function Controller() constructor {
    button_states = array_create(8, false);
    button_index = 0;
    strobe = 1;
    
    static byte_write = function(_input_bit, _val) {
        button_states[_input_bit] = _val;
    }
    
    static byte_read = function(_input_bit) {
        return button_states[_input_bit];
    }
    
    static button_set_state = function(_controller_input, _state) {
        button_states[_controller_input] = _state;
    }
}

// All 8 of the bits reserved for the inputs on the controller's data line, i think.
enum ControllerInput {
    A        = 0,
    B        = 1,
    Select   = 2,
    Start    = 3,
    Up       = 4,
    Down     = 5,
    Left     = 6,
    Righ     = 7
}
