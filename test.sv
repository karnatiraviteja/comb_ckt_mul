class test extends uvm_test;
  
  `uvm_component_utils(test)
  
  function new(string name = "test", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  env e;
  generator g;
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    e = env::type_id::create("e", this);
    g = generator::type_id::create("g");
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    g.start(e.a.seqr);
    phase.drop_objection(this);
  endtask
  
endclass
