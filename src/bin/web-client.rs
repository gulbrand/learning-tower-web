
#[macro_use]
extern crate tower_web;
extern crate tokio;

use std::collections::HashMap;

use tower_web::ServiceBuilder;
use tower_web::middleware::cors::{CorsBuilder, AllowedOrigins};
use tokio::prelude::*;

#[derive(Clone, Debug)]
struct HelloWorld;

#[derive(Response)]
struct HelloResponse {
    message: String,
}

impl_web! {
    impl HelloWorld {
        #[get("/")]
        #[content_type("json")]
        fn hello_world(&self) -> Result<HelloResponse, ()> {
            println!("responding to request");
            // let resp = reqwest::blocking::get("http://learning-tower-web.default.svc.cluster.local:8000/");

            // .json::<HashMap<String, String>>()?;

            Ok(HelloResponse {
                message: String::from("hello from app 2"),
            })
        }
    }
}

pub fn main() {
    let addr = "0.0.0.0:3002".parse().expect("Invalid address");
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
