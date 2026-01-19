draw_set_font(fnt_8bit);
draw_text(1, 1, string_concat("FPS: ", fps, ", TPS: ", fps_real, "\nMemory: ", memory_used.totalUsed / power(10, 6), "MB / ", memory_used.peakUsage / power(10, 6), "MB"));
