#!/usr/bin/env ruby
# Credit: Homebrew (https://brew.sh)
certs_list = `security find-certificate -a -p /System/Library/Keychains/SystemRootCertificates.keychain`

certs = certs_list.scan(
  /-----BEGIN CERTIFICATE-----.*?-----END CERTIFICATE-----/m,
)

valid_certs = certs.select do |cert|
  IO.popen("/Users/ajh/build/bin/openssl x509 -inform pem -checkend 0 -noout", "w") do |openssl_io|
    openssl_io.write(cert)
    openssl_io.close_write
  end
  $?.success?
end

IO.write("cert.pem", valid_certs.join("\n"))
