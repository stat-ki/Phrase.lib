require "refile/s3"

aws = {
  access_key_id: EVN['S3_ACCESS_KEY'],
  secret_access_key: EVN['S3_SECRET_KEY'],
  region: "ap-northeast-1",
  bucket: "phraselib",
}
Refile.cache = Refile::S3.new(prefix: "cache", **aws)
Refile.store = Refile::S3.new(prefix: "store", **aws)