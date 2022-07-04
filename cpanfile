# This file is generated by Dist::Zilla::Plugin::CPANFile v6.024
# Do not edit this file directly. To change prereqs, edit the `dist.ini` file.

requires "Dist::Zilla" => "0";
requires "Dist::Zilla::File::FromCode" => "0";
requires "Dist::Zilla::Plugin::CheckChangeLog" => "0.05";
requires "Dist::Zilla::Plugin::Git" => "2.046";
requires "Dist::Zilla::Plugin::GithubMeta" => "0";
requires "Dist::Zilla::Plugin::MetaProvides::Package" => "0";
requires "Dist::Zilla::Plugin::PodWeaver" => "0";
requires "Dist::Zilla::Plugin::PruneAliases" => "0";
requires "Dist::Zilla::Plugin::RunExtraTests" => "0";
requires "Dist::Zilla::Plugin::Test::MinimumVersion" => "0";
requires "Dist::Zilla::Role::FileGatherer" => "0";
requires "Dist::Zilla::Role::PluginBundle::Easy" => "0";
requires "Encode" => "0";
requires "Moose" => "0";
requires "Pod::Elemental" => "0";
requires "Pod::Elemental::Element::Nested" => "0";
requires "Pod::Elemental::Element::Pod5::Ordinary" => "0";
requires "Pod::Text" => "0";
requires "Pod::Weaver" => "4.009";
requires "Pod::Weaver::Config::Assembler" => "0";
requires "Pod::Weaver::Role::Section" => "0";
requires "Software::License" => "0.103014";
requires "namespace::autoclean" => "0";
requires "perl" => "5.026";

on 'test' => sub {
  requires "Test::DZil" => "0";
  requires "Test::Exception" => "0";
  requires "Test::More" => "0";
  requires "Test::Warnings" => "0";
};

on 'configure' => sub {
  requires "ExtUtils::MakeMaker" => "0";
};

on 'develop' => sub {
  requires "Dist::Zilla::Plugin::Bootstrap::lib" => "0";
  requires "Dist::Zilla::Plugin::Run::AfterBuild" => "0.047";
  requires "Test::MinimumVersion" => "0";
  requires "Test::More" => "0";
  requires "Test::Pod" => "1.41";
};
