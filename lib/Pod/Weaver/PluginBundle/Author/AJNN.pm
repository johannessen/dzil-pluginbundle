use 5.026;
use warnings;

package Pod::Weaver::PluginBundle::Author::AJNN;
# ABSTRACT: AJNN Pod::Weaver configuration


use Pod::Weaver 4.009;
use Pod::Weaver::Config::Assembler;

use Pod::Weaver::PluginBundle::Author::AJNN::Author;
use Pod::Weaver::PluginBundle::Author::AJNN::License;


sub _exp {
	my ( $moniker ) = @_;
	return Pod::Weaver::Config::Assembler->expand_package( $moniker );
}


sub mvp_bundle_config {
	return (
		[ '@AJNN/CorePrep',       _exp('@CorePrep'), {} ],
		[ '@AJNN/SingleEncoding', _exp('-SingleEncoding'), {} ],
		[ '@AJNN/Name',           _exp('Name'), {} ],
		[ '@AJNN/Version',        _exp('Version'), {} ],
		
		[ '@AJNN/Leftovers',      _exp('Leftovers'), {} ],
		
		[ '@AJNN/Author',  __PACKAGE__ . '::Author', {} ],
		[ '@AJNN/License', __PACKAGE__ . '::License', {} ],
	);
}


1;

__END__

=head1 SYNOPSIS

 package Dist::Zilla::PluginBundle::Author::AJNN;
 
 use Pod::Weaver::PluginBundle::Author::AJNN;
 
 use Moose;
 with 'Dist::Zilla::Role::PluginBundle::Easy';
 
 sub configure {
   shift->add_plugins(
     ...,
     [ 'PodWeaver' => { config_plugin => '@Author::AJNN' } ],
   );
 }

or in F<dist.ini>:

 [PodWeaver]
 config_plugin = @Author::AJNN

=head1 DESCRIPTION

This is the configuration I use for L<Dist::Zilla::Plugin::PodWeaver>.
Most likely you don't want or need to read this.

=head1 EQUIVALENT INI CONFIG

This plugin bundle is nearly equivalent to the following C<weaver.ini> config:

 [@CorePrep]
 [-SingleEncoding]
 [Name]
 [Version]
 
 [Leftovers]
 
 [@Author::AJNN::Author]
 [@Author::AJNN::License]

=head1 BUGS

This configuration is hacked together specifically for AJNN's needs.
It has not been designed with extensibility or reusability in mind.
No forward or backward compatibility should be expected.

=head1 SEE ALSO

L<Dist::Zilla::PluginBundle::Author::AJNN>

L<Pod::Weaver::PluginBundle::Author::AJNN::Author>

L<Pod::Weaver::PluginBundle::Author::AJNN::License>

L<Pod::Weaver::PluginBundle::Default>

L<Dist::Zilla::Plugin::PodWeaver>

=cut
