use steel::steel_vm::ffi::FFIModule;

steel::declare_module!(create_module);

fn create_module() -> FFIModule {
    let module = FFIModule::new("steel/tui");
    module
}
