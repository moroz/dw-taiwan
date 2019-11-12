import EctoEnum

defenum(Diamondway.Enums.GuestSex, male: 1, female: 2)

# Unverified: default state
# Verified: The identity of the guest has been verified,
# but there is no basis to invited them to the course yet
# Invited: The identity of the guest has been verified,
# they are free to purchase tickets
# Backup: The identity of the guest has been verified,
# but they were rejected
# Canceled: The guest has already invited but has rejected
# the invitation him/herself
# Paid: Invited and have purchased a ticket
defenum(Diamondway.Enums.GuestStatus,
  unverified: 0,
  invited: 2,
  backup: 3,
  canceled: 4,
  paid: 5
)
