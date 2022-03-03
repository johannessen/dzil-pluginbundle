use 5.026;
use warnings;

package Dist::Zilla::PluginBundle::Author::AJNN::PruneAliases;
# ABSTRACT: Prune macOS aliases


use Dist::Zilla;
use Moose;
use namespace::autoclean;

with 'Dist::Zilla::Role::FilePruner';


sub prune_files {
	my ($self) = @_;
	
	my @aliases = grep { $self->_is_alias($_) } $self->zilla->files->@*;
	$self->zilla->prune_file($_) for @aliases;
}


sub _is_alias {
	my ($self, $file) = @_;
	
	# Try to read macOS alias magic number
	open my $fh, '<:raw', $file->name or return;
	my $data;
	my $success = read $fh, $data, 16;
	close $fh;
	$success or return;
	return 1 if $data eq "book\0\0\0\0mark\0\0\0\0";
	
	return;
};


__PACKAGE__->meta->make_immutable;

1;

__END__

=head1 DESCRIPTION

This plugin prunes all macOS alias files.

=head1 SEE ALSO

L<Dist::Zilla::PluginBundle::Author::AJNN>

L<Dist::Zilla::Plugin::PruneCruft>

L<https://en.wikipedia.org/wiki/Alias_(Mac_OS)>

=cut
