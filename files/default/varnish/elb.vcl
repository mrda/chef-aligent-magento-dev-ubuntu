# Backends
backend elb1 { .host = "localhost"; .port = "80"; .connect_timeout = 15s; .first_byte_timeout = 3600s; .between_bytes_timeout = 3600s; }
backend elb2 { .host = "localhost"; .port = "80"; .connect_timeout = 15s; .first_byte_timeout = 3600s; .between_bytes_timeout = 3600s; }

# Round Robin Director
director elb round-robin {
    { .backend = elb2; }
    { .backend = elb1; }
}