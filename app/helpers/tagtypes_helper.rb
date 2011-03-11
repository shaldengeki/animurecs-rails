module TagtypesHelper
	# displays a dropdown select list of all the tagtypes.
	def tagtypes_dropdown
		collection_select(:tag, :tagtype_id, Tagtype.all, :id, :name, :prompt => true)
	end
end
