class generator extends uvm_sequence #(transaction);
  
  `uvm_object_utils(generator)
  
  transaction t;
  
  function new(string name = "generator");
    super.new(name);
  endfunction
  
  virtual task body();
    `uvm_info(get_name(), "GENERATOR BODY STARTED", UVM_LOW);
    t = transaction::type_id::create("t");
    repeat(6)
      begin
        start_item(t);
        t.randomize();
        `uvm_info(get_name(), $sformatf("DATA SENT TO DRIVER, a: %0d and b: %0d", t.a, t.b), UVM_LOW);
        finish_item(t);
      end
    `uvm_info(get_name(), "GENERATOR BODY ENDED", UVM_LOW);
  endtask
  
  
endclass
