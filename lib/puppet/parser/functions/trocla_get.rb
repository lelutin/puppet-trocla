# frozen_string_literal: true

module Puppet
  module Parser
    # internal implementation of main lookup function for DSL
    module Functions
      newfunction(:trocla_get, type: :rvalue, doc: "
  This will only get an already stored password from the trocla storage.

Usage:

    $password_user1 = trocla_get(key,[format='plain'[,raise_error=true]])

Means:

    $password_user1 = trocla('user1')

Get the plain text password for the key 'user1'

    $password_user2 = trocla_get('user2','mysql')

Get the mysql style sha1 hashed password.

    $cert_x509_key = trocla_get('cert_x509','x509', 'render: keyonly')

Get the x509 style private key, by passing any trocla options as a third
argument.

By default puppet will raise a parse error if the password haven't yet been
stored in trocla. This can be turned off by setting false as a third argument:

    $password_user3 = trocla_get('user2','mysql',false)

or setting the 'raise_error' option to false:

    $password_user3 = trocla_get('user2','mysql', { raise_error => false })

the return value will be undef if the key & format pair is not found.
") do |*args|
        args = args[0] if args[0].is_a?(Array)
        require "#{File.dirname(__FILE__)}/../../util/trocla_helper"
        args[1] ||= 'plain'
        options = {}
        if args[2].nil?
          raise_error = true
        elsif args[2].is_a?(FalseClass) || args[2].is_a?(TrueClass)
          raise_error = args[2]
        else
          options = args[2]
          options = YAML.safe_load(options) if options.is_a?(String)
          unless options.is_a?(Hash)
            raise(Puppet::ParseError, 'Third argument to trocla_get must either be a boolean, yaml string or a hash')
          end

          raise_error = options.key?('raise_error') ? options.delete('raise_error') : true
        end
        if (answer = Puppet::Util::TroclaHelper.trocla(:get_password, false,
                                                       [args[0], args[1], options])).nil? && raise_error
          raise(Puppet::ParseError, "No password for key,format #{args[0..1].flatten.inspect} found!")
        end

        answer.nil? ? :undef : answer
      end
    end
  end
end
