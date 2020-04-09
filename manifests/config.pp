# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include influxdb::config
define influxdb::config (
  $package                            = $influxdb::package,
  $service                            = $influxdb::service,
  $enable                             = $influxdb::enable,
  $manage_repo                        = $influxdb::manage_repo,
  $apt_location                       = $influxdb::apt_location,
  $apt_release                        = $influxdb::apt_release,
  $apt_repos                          = $influxdb::apt_repos,
  $apt_key                            = $influxdb::apt_key,
  $influxdb_package_name              = $influxdb::influxdb_package_name,
  $influxdb_service_name              = $influxdb::influxdb_service_name,
  $influxdb_service_provider          = $influxdb::influxdb_service_provider,
  $influxdb_config_dir                = $influxdb::influxdb_config_dir,
  $influxdb_config_file               = $influxdb::influxdb_config_file,

  $hostname                           = $influxdb::hostname,
  $libdir                             = $influxdb::libdir,
  $admin_enable                       = $influxdb::admin_enable,
  $admin_bind_address                 = $influxdb::admin_bind_address,
  $admin_username                     = $influxdb::admin_username,
  $admin_password                     = $influxdb::admin_password,
  $domain_name                        = $influxdb::domain_name,
  $flux_enable                        = $influxdb::flux_enable,
  $http_enable                        = $influxdb::http_enable,
  $http_bind_address                  = $influxdb::http_bind_address,
  $http_auth_enabled                  = $influxdb::http_auth_enabled,
  $http_realm                         = $influxdb::http_realm,
  $http_log_enabled                   = $influxdb::http_log_enabled,
  $https_enable                       = $influxdb::https_enable,
  $http_bind_socket                   = $influxdb::http_bind_socket,
  $logging_format                     = $influxdb::logging_format,
  $logging_level                      = $influxdb::logging_level,
  $index_version                      = $influxdb::index_version,
  $cache_max_memory_size              = $influxdb::cache_max_memory_size,
  $cache_snapshot_memory_size         = $influxdb::cache_snapshot_memory_size,
  $cache_snapshot_write_cold_duration = $influxdb::cache_snapshot_write_cold_duration,
  $compact_full_write_old_duration    = $influxdb::compact_full_write_old_duration,
  $max_series_per_database            = $influxdb::max_series_per_database,
  $max_values_per_tag                 = $influxdb::max_values_per_tag,
  $udp_enable                         = $influxdb::udp_enable,
  $udp_bind_address                   = $influxdb::udp_bind_address,
  $graphite_enable                    = $influxdb::graphite_enable,
  $graphite_database                  = $influxdb::graphite_database,
  $graphite_listen                    = $influxdb::graphite_listen,
  $graphite_templates                 = $influxdb::graphite_templates,
) {

  file { "influxdb_config_file_${name}":
    ensure  => $influxdb::ensure_package,
    path    => "${influxdb_config_dir}/${name}_${influxdb_config_file}",
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('influxdb/influxdb.conf.erb'),
    require => Package[$influxdb_package_name[0]],
    notify  => Exec["influxdb_config_tmp_${name}"]
  }

  exec { "influxdb_config_tmp_${name}":
    path    => '/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin',
    command => "cp ${influxdb_config_dir}/${name}_${influxdb_config_file} \
      ${influxdb_config_dir}/${influxdb_config_file}",
    # onlyif  => "test ! -f ${influxdb_config_dir}/${influxdb_config_file}"

  }


}
