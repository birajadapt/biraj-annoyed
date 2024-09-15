[sinks.loki]
type = "loki"

# see vector.toml.tpl file for details
inputs = ["transform_nomad_alloc_*"] 

# loki server details
endpoint = "https://logs-prod-006.grafana.net"


# Encoding for the logs
encoding.codec = "json"

# labels for logs
labels.nomad_job_id = ".nomad.job_id"
labels.function_id = ".nomad.job_meta_function_id"
labels.user_id = ".nomad.job_meta_user_id"
labels.nomad_alloc_id = ".nomad.alloc_id"

# .file will be a string but vector doesn't know that and will throw an error
# because it's .file would be implicitly any. hence using to_string() with 
# a fallback since it could potentially throw an error when .file is not available
labels.stream = 'if contains(to_string(.file) ?? "to_string() failed", "stdout") { "stdout" } else { "stderr" }'
