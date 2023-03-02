#![cfg_attr(
  all(not(debug_assertions), target_os = "windows"),
  windows_subsystem = "windows"
)]

#[tauri::command]
fn custom_null_to_null() {
  println!("I was invoked from JS!");
}

#[tauri::command]
fn custom_null_to_string() -> String {
  "Rust()".into()
}

#[tauri::command]
fn custom_string_to_null(invoke_message: String) {
  println!("{}", invoke_message);
}

#[tauri::command]
fn custom_string_to_string(invoke_message: String) -> String {
  format!("Rust({})", invoke_message).into()
}

fn main() {
  tauri::Builder::default()
    .invoke_handler(tauri::generate_handler![custom_null_to_null, custom_null_to_string, custom_string_to_null, custom_string_to_string])
    .run(tauri::generate_context!())
    .expect("error while running tauri application");
}
