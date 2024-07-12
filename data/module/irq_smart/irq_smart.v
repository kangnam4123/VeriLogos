module irq_smart        (sclk,               
                         wen,                
                         di,                 
                         frame_sync,         
                         is_compressing,      
                         compressor_done,    
                         fifo_empty,         
                         irq);                
    input         sclk;
    input         wen;
    input  [15:0] di;
    input         frame_sync;         
    input         is_compressing;     
    input         compressor_done;    
    input         fifo_empty;         
    output        irq;                
    reg    [2:0]  is_compressing_s;
    reg           is_finishing=0; 
    reg           was_finishing;
    reg           wait_frame_sync;
    reg           wait_fifo;
    reg           compressor_fifo_done; 
    reg           done_request  = 0;
    reg           irq;
    reg           rst;
    wire          will_postpone_fs; 
    wire          end_postpone_fs;
    wire          finished;
    reg           fs_postponed;
    wire          will_delay_done_irq;
    reg           delaying_done_irq;
    assign   will_postpone_fs=wait_frame_sync && (is_compressing_s[2] || is_finishing) ;
    assign   finished=was_finishing && ! is_finishing;
    assign   end_postpone_fs=finished || frame_sync;
    assign   will_delay_done_irq=wait_frame_sync && (finished && !fs_postponed);
    always @ (negedge sclk) begin
     if (wen & di[1]) wait_frame_sync <= di[0];
     if (wen & di[3]) wait_fifo       <= di[2];
     rst <=wen & di[15];
     fs_postponed <= !rst && ((will_postpone_fs && frame_sync) || (fs_postponed && !end_postpone_fs));
     delaying_done_irq <= !rst &&  (will_delay_done_irq || (delaying_done_irq && !frame_sync));
     is_compressing_s[2:0]<={is_compressing_s[1:0],is_compressing} ; 
     done_request  <= !rst && (compressor_done || (done_request &&  !compressor_fifo_done));
     compressor_fifo_done <= done_request && (!wait_fifo || fifo_empty) && !compressor_fifo_done;
     is_finishing <=  !rst && ((is_compressing_s[2] && !is_compressing_s[1]) || 
                               (is_finishing && !compressor_fifo_done));
     was_finishing <= is_finishing;
     irq <= !rst && ((frame_sync &&  (!will_postpone_fs || delaying_done_irq)) ||
                     (fs_postponed && end_postpone_fs) || 
                     (!will_delay_done_irq && finished));
    end
endmodule