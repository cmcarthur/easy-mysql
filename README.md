easy-mysql
==========

An easy way to set up a read-only MySQL connection secured by SSH. When run, this gem will:

 - Create a new MySQL user with `SELECT` privileges
 - Create a new Linux user with an ssh public key in place for passwordless tunnelling
 - Return the generated credentials

### Installation

To install, simply run:

```
gem install easy-mysql
```

You can run with:

```
rvmsudo easy-mysql
```

Now, just follow the prompts!
