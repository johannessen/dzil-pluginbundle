use 5.026;
use warnings;

package Dist::Zilla::PluginBundle::Author::AJNN::Readme;
# ABSTRACT: Build a README file for AJNN's distributions


use Dist::Zilla;
use Dist::Zilla::File::FromCode;
use Encode;
use Moose;
use namespace::autoclean;
use Pod::Elemental;
use Pod::Text;

use Pod::Weaver::PluginBundle::Author::AJNN::License;

with 'Dist::Zilla::Role::FileGatherer';


has cpan_release => (
	is => 'ro',
	isa => 'Str',
	lazy => 1,
	default => sub { '1' },
);


sub gather_files {
	my ($self, $arg) = @_;
	
	$self->add_file(
		Dist::Zilla::File::FromCode->new(
			name => 'README',
			code => sub { $self->_readme },
		),
	);
}


sub _readme {
	my ($self) = @_;
	
	return join "\n\n", (
		$self->_readme_header,
		$self->_readme_install,
		$self->_readme_license,
	);
}


sub _readme_header {
	my ($self) = @_;
	
	my $main_module  = $self->_main_module_name;
	my $dist_version = $self->zilla->version;
	my $dist_name    = $self->zilla->name;
	my $trial_rel    = $self->zilla->is_trial ? " (TRIAL RELEASE)" : "";
	
	my $description = $self->_main_module_description;
	$description =~ s/\n\n.*$//;  # only keep the first paragraph
	
	my $link = $self->zilla->distmeta->{resources}{repository}{web};
	$link = "https://metacpan.org/release/$dist_name" if $self->cpan_release;
	
	return <<END;
$main_module $dist_version$trial_rel

$description

More information about this software:
$link
END
}


sub _readme_install {
	my ($self) = @_;
	
	my $main_module = $self->_main_module_name;
	my $archive = $self->zilla->name . '-' . $self->zilla->version . '.tar.gz';
	
	my $text = <<END;
INSTALLATION

END
	if ($self->cpan_release) {
		$text .= <<END;
The recommended way to install this Perl module distribution is directly
from CPAN with whichever tool you use to manage your installation of Perl.
For example:

  cpanm $main_module

If you already have downloaded the distribution, you can alternatively
point your tool directly at the archive file or the directory:

END
	}
	else {
		$text .= <<END;
To install this Perl module distribution, point whichever tool you use
to manage your installation of Perl directly at the archive file or the
directory. For example:

END
	}
	$text .= <<END;
  cpanm $archive

You can also install the module manually by following these steps:

  perl Makefile.PL
  make
  make test
  make install

See https://www.cpan.org/modules/INSTALL.html for general information
on installing CPAN modules.
END
	
	return $text;
}


sub _readme_license {
	my ($self) = @_;
	
	my $notice = Pod::Weaver::PluginBundle::Author::AJNN::License->notice_maybe_mangled(
		$self->zilla->license,
		$self->zilla->authors,
	);
	return "COPYRIGHT AND LICENSE\n\n" . $notice;
}


sub _main_module_name {
	my ($self) = @_;
	
	my $name = $self->zilla->main_module->name;
	$name =~ s{^lib/|\.pm$}{}g;
	$name =~ s{/}{::}g;
	return $name;
}

	
sub _main_module_description {
	my ($self) = @_;
	
	my $pod = $self->zilla->main_module->content;
	$pod = Encode::encode( 'UTF-8', $pod, Encode::FB_CROAK );
	my $document = Pod::Elemental->read_string( $pod );
	my $desc_found;
	for my $element ($document->children->@*) {
		if ($desc_found) {
			next unless $element->isa('Pod::Elemental::Element::Generic::Text');
			my $parser = Pod::Text->new( indent => 0 );
			$parser->output_string( \( my $text ) );
			$parser->parse_string_document( "=pod\n\n" . $element->content );
			$text =~ s/^\s+//;
			$text =~ s/\s+$//;
			return $text || $self->zilla->abstract;
		}
		$desc_found = $element->isa('Pod::Elemental::Element::Generic::Command')
		              && $element->command eq 'head1'
		              && $element->content =~ m/\s*DESCRIPTION\s*/;
	}
	
	return $self->zilla->abstract;
}


__PACKAGE__->meta->make_immutable;

1;

__END__

=head1 DESCRIPTION

Provides a F<README> file which only contains the most important information
for someone who may have extracted the distribution archive, but is unsure
what it is and what to do with it.

In particular, the following content is included in the F<README>:

=over

=item * main module name

=item * distribution version number

=item * first paragraph of the distribution POD's description section
(or the abstract, if the description can't be found or is empty)

=item * URL of the distribution's home page on MetaCPAN

=item * installation instructions (for both tools and manual)

=item * author identification

=item * license statement

=back

It may be assumed that people who are already familiar with Perl and
its ecosystem won't usually read the F<README> accompanying a CPAN
distribution. They typically get all they need to know from MetaCPAN,
and are accustomed to C<cpanm> and other tools. Non-Perl people, however,
might not know how to install a Perl distribution or how to access the
documentation. In my opinion, I<this> is the information a CPAN distro
F<README> really needs to provide.

Identification of the module, on the other hand, may be kept very brief.
A license file is included with the distribution, so stating the license
is generally not required; however, this plugin will pick up any mangling
done by L<Pod::Weaver::PluginBundle::Author::AJNN::License>.

=head1 ATTRIBUTES

=head2 cpan_release

Whether the distribution is available on L<CPAN|https://www.cpan.org/>.
The default is yes. If set to no, the link in the readme will be changed
to GitHub and CPAN will no longer be mentioned in the installation
instructions.

 cpan_release = 0

=head1 SEE ALSO

L<Dist::Zilla::PluginBundle::Author::AJNN>

L<Pod::Weaver::PluginBundle::Author::AJNN::License>

L<Dist::Zilla::Plugin::Readme>

L<Dist::Zilla::Plugin::Readme::Brief>

=cut
