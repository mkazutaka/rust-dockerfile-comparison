#[macro_use] extern crate rocket;

#[cfg(test)] mod tests;

#[get("/")]
fn hello() -> &'static str {
    "Hello, after build!"
}

#[launch]
fn rocket() -> rocket::Rocket {
    rocket::ignite().mount("/", routes![hello])
}