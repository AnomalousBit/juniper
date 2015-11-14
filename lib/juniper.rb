class TreeNode

	attr_accessor :parent_node, :children_nodes, :data

	attr_reader :push_method



	def initialize(parent_node=nil)
		raise TypeError if !parent_node.nil? && !parent_node.is_a?(TreeNode)

		@push_method = :push_child
		
		if !parent_node.nil?
			#parent_node.send(@push_method, self)
			@push_method = parent_node.push_method
		end

		@parent_node = parent_node 

		@children_nodes = []
	end


	#configuration methods

	def require_unique_nodes(required)
		#@require_unique_nodes = required
		if required
			@push_method = :push_unique_child 
		else
			@push_method = :push_child
		end
	end



	def push_child(child_node_data)
		new_node = TreeNode.new(self)
		new_node.data = child_node_data

		@children_nodes.push(new_node)

		return new_node
	end



	def push_unique_child(child_node_data)
		if !self.tree_contains?(child_node_data)
			new_node = TreeNode.new(self)
			new_node.data = child_node_data

			@children_nodes.push(new_node)
			return new_node
		else
			raise NonUniqueNodeError, "Tree already contains the node being pushed"
		end
	end


	#search methods

	def ancestors_contains?(data_to_check)
		return true if @data == data_to_check
		return false if @parent_node.nil?

		@parent_node.descendents_contains?(data_to_check)
	end



	def children_contains?(data_to_check)
		@children_nodes.each { |child| return true if child.data == data_to_check }
		@children_nodes.each { |child| return true if child.children_contains?(data_to_check) }

		return false
	end



	def tree_contains?(data_to_check)
		if @parent_node.nil?
			return true if @data == data_to_check
			return self.children_contains?(data_to_check)
		else
			parent_node.tree_contains?(data_to_check)
		end
	end



	def find_root_node
		if @parent_node.nil?
			return self
		else
			@parent_node.find_root_node
		end
	end


	#iterative methods

	def each_in_tree
		root_node = self.find_root_node

		yield root_node

		root_node.each_child_in_tree { |child| yield child }
	end



	def each_child_in_tree
		@children_nodes.each { |child| yield child; child.each_child_in_tree { |grandchild| yield grandchild } }
	end


end
