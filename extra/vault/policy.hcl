path "onyxia-kv/{{identity.entity.aliases.auth_jwt_e230c5d4.name}}/*" {
  capabilities = ["create","update","read","delete","list"]
}

path "onyxia-kv/data/{{identity.entity.aliases.auth_jwt_e230c5d4.name}}/*" {
  capabilities = ["create","update","read"]
}

path "onyxia-kv/metadata/{{identity.entity.aliases.auth_jwt_e230c5d4.name}}/*" {
  capabilities = ["delete", "list", "read"]
}
