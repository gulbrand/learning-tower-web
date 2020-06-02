#[macro_use]
extern crate tower_web;
extern crate tokio;

use tower_web::{ServiceBuilder};
use tower_web::middleware::cors::{CorsBuilder, AllowedOrigins};
use tokio::prelude::*;

#[derive(Clone, Debug)]
struct HelloWorld;

#[derive(Response, Debug)]
struct HelloResponse {
    message: &'static str,
}

impl_web! {
    impl HelloWorld {
        #[get("/")]
        #[content_type("json")]
        fn hello_world(&self) -> Result<HelloResponse, ()> {
            let message = "hello from app 1";
            let response = HelloResponse {message};
            println!("responding to request with {:?}", response);
            Ok(response)
        }
    }
}

pub fn main() {
    let addr = "0.0.0.0:3001".parse().expect("Invalid address");
    println!("Listening on http://{}", addr);

    ServiceBuilder::new()
        .resource(HelloWorld)
        .middleware(
            CorsBuilder::new()
                .allow_origins(AllowedOrigins::Any { allow_null: true })
                .build()
        )
        .run(&addr)
        .unwrap();
}
