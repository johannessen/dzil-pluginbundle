use 5.026;
use warnings;

package Pod::Weaver::PluginBundle::Author::AJNN::Author;
# ABSTRACT: Pod section naming the author


use Carp qw(croak);
use Moose;
use namespace::autoclean;
use Pod::Elemental::Element::Nested;
use Pod::Elemental::Element::Pod5::Ordinary;

with 'Pod::Weaver::Role::Section';


our $HEADER = 'AUTHOR';


sub weave_section {
	my ($self, $document, $input) = @_;
	
	my $author = $input->{authors}->[0];
	
	croak "Unsupported declaration of multiple authors in dist.ini" if $input->{authors}->@* > 1;

	if ( $author =~ m/<ajnn\@cpan\.org>/ ) {
		$author .= <<~END;
			\n
			If you contact me by email, please make sure you include the word
			"Perl" in your subject header to help beat the spam filters.
			END
	}
	
	push $document->children->@*, Pod::Elemental::Element::Nested->new({
		command  => 'head1',
		content  => $HEADER,
		children => [ Pod::Elemental::Element::Pod5::Ordinary->new({
			content => $author,
		})],
	});
}


__PACKAGE__->meta->make_immutable;

1;

__END__

=head1 SYNOPSIS

 package Pod::Weaver::PluginBundle::Author::AJNN;
 
 use Pod::Weaver::PluginBundle::Author::AJNN::Author;
 
 sub mvp_bundle_config {
   return (
     ...,
     [ '@AJNN/Author', __PACKAGE__ . '::Author', {}, ],
   )
 }

=head1 DESCRIPTION

This package provides AJNN's customised author statement.

In particular, if AJNN is declared as a distribution's only author,
a note is added that may help spam filtering.

=head1 BUGS

Multiple authors are unsupported.

=head1 SEE ALSO

L<Pod::Weaver::PluginBundle::Author::AJNN>

L<Pod::Weaver::Section::Authors>

=cut
