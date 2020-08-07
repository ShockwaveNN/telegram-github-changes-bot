# frozen_string_literal: true

require 'spec_helper'

describe GithubRepoChanges do
  let(:github_changes) { described_class.new(repo: 'ONLYOFFICE/sdkjs') }

  before { github_changes.refs_from_message('/get_changes master...develop') }

  it 'expect old_ref is correct' do
    expect(github_changes.old_ref).to eq('master')
  end

  it 'expect new_ref is correct' do
    expect(github_changes.new_ref).to eq('develop')
  end

  it 'Check changes for existing refs' do
    expect(github_changes.link_to_changes).to include('github.com')
  end

  it 'Check correct message if single ref - is the latest ref' do
    github_changes.fetch_refs
    newset_ref = github_changes.refs.first
    github_changes.refs_from_message("/get_changes #{newset_ref}")
    expect(github_changes.link_to_changes)
      .to match(/Your specified version is the latest version/)
  end
end
