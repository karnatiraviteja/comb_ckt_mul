class driver extends uvm_driver #(transaction);
  
  `uvm_component_utils(driver)
  
  function new(string name = "driver", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  transaction tc;
  virtual mul_if mif;
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    tc = transaction::type_id::create("tc");
    if(!uvm_config_db #(virtual mul_if)::get(this, "", "mif", mif))
      begin
        `uvm_error(get_name(), "Unable to aceess uvm_config_db");
      end
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    `uvm_info(get_name(), "DRIVER RUN PHASE STARTED", UVM_LOW);
    forever begin
      seq_item_port.get_next_item(tc);
      mif.a <= tc.a;
      mif.b <= tc.b;
      seq_item_port.item_done(tc);
      `uvm_info(get_name(), $sformatf("TRIGGER DUT, a: %0d and b: %0d", tc.a, tc.b), UVM_LOW);
      #10;
    end
    `uvm_info(get_name(), "DRIVER RUN PHASE ENDED", UVM_LOW);
  endtask
  
endclass
