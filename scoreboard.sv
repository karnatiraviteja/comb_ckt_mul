class scoreboard extends uvm_scoreboard;
  `uvm_component_utils(scoreboard)
  
  uvm_analysis_imp #(transaction, scoreboard) rcvd;
  transaction tr;
  
  function new(string name = "scoreboard", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    rcvd = new("rcvd", this);
    tr = transaction::type_id::create("tr");
  endfunction
  
  virtual function void write(input transaction t);
    tr = t;
    `uvm_info(get_name(), $sformatf("DATA RECEIVED FROM MONITOR, a: %0d, b: %0d and y: %0d", tr.a, tr.b, tr.y), UVM_LOW);
    if(tr.y == tr.a * tr.b) begin
      `uvm_info(get_name(), "TEST PASSED", UVM_LOW)
    end
    else begin
      `uvm_info(get_name(), "TEST FAILED", UVM_LOW)
    end
  endfunction
  
endclass
