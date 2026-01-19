draw_set_font(fnt_8bit);
var str = string_concat("FPS: ", fps, ", TPS: ", fps_real, "\nMemory: ", (memory_used.totalUsed - memory_used.free) / power(10, 6), "MB / ", memory_used.totalUsed / power(10, 6), "MB");
draw_text(1, 1, str);
draw_text(1, 1 + string_height(str), string_concat(mem_info.address, " ", mem_info.data));
