class monitor extends uvm_monitor;
  
  `uvm_component_utils(monitor)
  
  uvm_analysis_port #(transaction) send;
  
  function new(string name = "monitor", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  transaction t;
  virtual mul_if mif;
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    send = new("send", this);
    t = transaction::type_id::create("t");
    if(!uvm_config_db #(virtual mul_if)::get(this, "", "mif", mif)) begin
      `uvm_error(get_name(), "Unable to access uvm_config_db");
    end
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    forever begin
      #10;
      t.a = mif.a;
      t.b = mif.b;
      t.y = mif.y;
      `uvm_info(get_name(), $sformatf("DATA SENT TO SCOREBOARD, a: %0d, b: %0d and y: %0d", t.a, t.b, t.y), UVM_LOW);
      send.write(t);
    end
  endtask
  
endclass
