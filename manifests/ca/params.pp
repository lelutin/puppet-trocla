# @summary input for a ca from trocla
#
# @example using default option values for generating an x509 CA
#   trocla('some_ca','x509',$trocla::ca::params::ca_options)
#
# @param trocla_options
#   hash of parameters that are use for setting the default value ca_options.
#   Override this to change the values in the variable.
#
class trocla::ca::params (
  Hash $trocla_options = {
    'profiles' => ['sysdomain_nc','x509veryverylong'],
    'CN'       => "automated-ca ${name} for ${facts['networking']['domain']}",
  },
) {
  $ca_options = merge( $trocla_options, { become_ca => true, render => { certonly => true }, })
}
