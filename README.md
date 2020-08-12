Note - this is the code frozen for the HackFS 2020 submission as per August 6th. We continue to work on the app but we have not merged in more recent changes.


# CoCreate - An App for Songwriter Guilds

For every songwriter with their collection on SoundCloud (25M creators listened to by 76M monthly active users), there are many more who never get that far. But if every one of these creators put all their raw audio on Filecoin (think 20-30 tracks per song, plus backups etc.) that would be a lot of data to store! So we need a very big file system!

# The Idea

Many people can write songs but don’t have the resources or skills required to produce them. Others can write lyrics but can’t put them to music. There are many bedroom producers who are talented when it comes to using the tech, but cannot write great songs. And there are bedroom musicians who would love to be involved in the creative process of others. Our goal is to bring these people together.

We want to create a solution where everyone gets the credit for their contribution to the process of creating a new song. We need to move on from the old rules where the default was 50% to the lyric writer with 50% to the composer. Many great recordings feature inputs from musicians who didn’t earn a cent in royalties. Producers need to have built up a reputation before they can get cut in on royalties. We give everyone a chance to negotiate a fair share of royalties.

In CoCreate, the initial contributor uploads an idea. Maybe a verse and chorus. Maybe a whole song. Maybe a melody with no lyrics. Any user can take the original idea and work with it. Maybe add a middle eight. Maybe start production by putting down a guide track and starting to add more tracks. At the start, the initial contributor has full control. They decide what contributions they like and then they can approve them.

Once a part is approved, a negotiation takes place. The new contributor will request a share of the royalties for their contribution. If both parties agree on a fair split, then the combined song is now shared between them. When the next contributors come along, then the first two contributors have to jointly agree on where to take the song next. And it grows from there, each contributor gets a share and uses that voting share to make decisions on how to evolve the song.

At the end of the co-writing process we would have a song ready and push it straight to SoundCloud / Audius to find an audience.


# The Implementation

For this we use the idea of a DAO - a decentralized autonomous organization - a blockchain hosted cooperative, where members of the DAO get to vote for how the song evolves. In this case, there is one DAO for each song. And each contributor’s vote is weighted in proportion to their share of the song.  

In the future there are endless possibilities here. There could be multiple parallel versions of the song evolving in parallel, with different contributors. There are a whole host of legal issues to resolve around various royalty mechanisms. We may find that collaborators want to work together on multiple tracks and evolve into a band or collective. These are all things we will leave for later. For the hackathon we should get the basic ideas, where collaborators can upload ideas, select good ones, negotiate shares and vote on ongoing contributions. 

We are looking at using NFTs on Ethereum to represent the tracks (with a link to the IPFS audio) and maybe use a hierarchical structure of NFTs to represent the various versions of each track, every time someone adds a track to one version it could fork into two independent song lineages.
