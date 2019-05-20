Create Step Configuration
=

Actor
==

Administrator

Description
==

A step configuration represents a particular "screen" that should be displayed
to the user. Typically, these are combined into some kind of workflow.

Any given step should know nothing about the overall workflow. Instead, it
should be concerned with managing content on its screen and handling any
relevant client-side events which are triggered.

An administrator has the ability to define a new step configuration. Step
configurations are immutable. The only way to edit a step configuration is to
archive an existing one and create a new one.

A step configuration consists of:

- An ID (uuid)
- A (non-unique) human-readable name (string)
- A schema describing:
  - Allowed fields (potentially nested)
  - Required fields (potentially nested)
  - Types of all fields
  - Default values for optional fields (potentially `null`)

Preconditions
==
- The given ID must 

Postconditions
==

Happy Path
==

Alternative Happy Paths
==
1. First Happy Path
    1. Step

Sad Paths
==
1. First Sad Path
    1. Step

Validation Rules
==
- The acto

Notes
==
