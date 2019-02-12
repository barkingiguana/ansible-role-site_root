require 'spec_helper'

describe 'barkingiguana.site_root' do
  let(:admin1) { user('admin1') }
  let(:admin2) { user('admin2') }
  let(:admin3) { user('admin3') }
  let(:person1) { user('person1') }

  it 'creates the users' do
    expect(admin1).to exist
    expect(admin2).to exist
    expect(admin3).to exist
    expect(person1).to exist
  end

  it 'sets the uids' do
    expect(admin1).to have_uid('10001')
    expect(admin2).to have_uid('10002')
    expect(admin3).to have_uid('10003')
    expect(person1).to have_uid('10004')
  end

  it 'creates groups for each user' do
    expect(group('admin1')).to exist
    expect(group('admin2')).to exist
    expect(group('admin3')).to exist
    expect(group('person1')).to exist
  end

  it 'sets the gids' do
    expect(group('admin1')).to have_gid('10001')
    expect(group('admin2')).to have_gid('50002')
    expect(group('admin3')).to have_gid('10003')
    expect(group('person1')).to have_gid('10004')
  end

  it 'creates the wheel group' do
    expect(group('admingrp')).to exist
  end

  it 'sets the gid for the wheel group' do
    expect(group('admingrp')).to have_gid('50001')
  end

  it 'adds the users to their own group' do
    expect(admin1).to belong_to_primary_group 'admin1'
    expect(admin2).to belong_to_primary_group 'admin2'
    expect(admin3).to belong_to_primary_group 'admin3'
    expect(person1).to belong_to_primary_group 'person1'
  end

  it 'adds the users to the wheel group' do
    expect(admin1).to belong_to_group 'admingrp'
    expect(admin2).to belong_to_group 'admingrp'
    expect(admin3).to belong_to_group 'admingrp'
    expect(person1).not_to belong_to_group 'admingrp'
  end

  it 'adds the users to additional groups' do
    expect(admin3).to belong_to_group 'audio'
  end

  it 'adds a group permission to /etc/sudoers for the wheel group' do
    expect(file('/etc/sudoers').content).to include('%admingrp ALL=(ALL:ALL) NOPASSWD:ALL')
  end

  it 'sets manages the users ssh keys' do
    expect(admin1).to have_authorized_key('ssh-rsa key1 comment1')
    expect(admin2).to have_authorized_key('ssh-rsa key2.1 comment2.1')
    expect(admin2).to have_authorized_key('ssh-rsa key2.2 comment2.2')
    expect(admin3).to have_authorized_key('ssh-rsa key3 comment3')
    expect(person1).to have_authorized_key('ssh-rsa key4 comment4')
  end
end
