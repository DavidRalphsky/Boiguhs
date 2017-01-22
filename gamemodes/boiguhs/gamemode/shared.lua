GM.Name = "Boiguhs!"
GM.Author = "David Ralphsky"

DeriveGamemode("base")

function GM:Initialize()
	self.BaseClass.Initialize(self)
end
