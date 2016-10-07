barkingiguana.site\_root
=========

Manage site root users.

When you get a new EC2 box (for example), you'll have access to the `ec2-user`
or `ubuntu` or something like that. Rather than having my playbooks remember
which machines need which user to log in as, in order to run Ansible and perform
administrative actions, I prefer to have a consistent "site root" user which has `sudo` access.

I've noticed this same pattern over several of my clients, so I've written this
role to make sure I don't have to write it again!

Requirements
------------

None

Role Variables
--------------

  * `site_root_users`.
  An array of users to create as site\_root users. See the example playbook
  below for the structure of this variable. Default: `[]`.

  * `site_root_wheel_group_name`.
  The name of the group to use as the wheel group.
  This group is granted access to `sudo`. Default: `siteroot`.

  * `site_root_wheel_group_id`.
  The id of the `site_root_wheel_group_name`. Default: `50000`.

Dependencies
------------

None

Example Playbook
----------------

    - hosts: servers
      vars:
        site_root_wheel_group_name: admingrp
        site_root_users:
          - user:
            username: admin019
            uid: 50500
            shell: /bin/csh
            authorized_keys:
              - "ssh-rsa AAAA...Q== craig@xi.local"
              - "ssh-rsa AAAA...Q== charlotte@mu.local"
      roles:
        - barkingiguana.site_root

License
-------

MIT. See the LICENCE file.
