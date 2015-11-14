# juniper

Juniper is a simple tree structure written in plain Ruby without any outside dependencies.

juniper:
* Allows you to **store any valid Ruby object**, array, hash, etc. as the data element
* Permits **one parent with any number of children**
* Provides Ruby-familiar accessors and methods for **traversal, searching, and iteration**


## Create a Tree
```
parentNode = new Node({ name: 'House'})

#parentNode's children
door_node    = parentNode.push_child({ name: 'Doors'})
windows_node = parentNode.push_child({ name: 'Windows'})
walls_node   = parentNode.push_child({ name: 'Walls'})

#door_node's children
wood_node  = door_node.push_child({ name: 'Wood'})
nails_node = door_node.push_child({ name: 'Nails'})
nails_node = door_node.push_child({ name: 'Knob'})
```

## Access your Data, Search and Iterate
```
# Access your data inside of a node
puts parentNode.data[:name]    # prints 'House' to console
puts parentNode.children.first.data[:name]     # prints 'Doors' to console


# find element in the tree
node_result = parentNode.find_node({ name: 'Wood'})    # returns the node with all relationships
node_nil_result = parentNode.find_node({ name: 'Glue')    # returns nil


# search the tree for presence
parentNode.node_exists_in_tree?({ name: 'Nails'}) # returns true
parentNode.node_exists_in_tree?({ name: 'Sticks') # returns false


# execute a method on every node in the tree
parentNode.each_node { |node| puts node.data[:name] }

```

## Motivation

The concept for juniper is to quickly incorporate existing data into a tree structure and provide easy-to-use methods for manipulation and examination.


## Installation

for general Ruby usage, from the console run:
`gem install juniper`

then simply include the module at the top of your ruby file where you wish to create a tree:

`require 'juniper'`

for use with rails / bundle, add the following line to your Gemfile

`gem 'juniper', git: 'https://github.com/AnomalousBit/juniper.git'`


## API Reference

All tree-related properties and methods are accessible via any single `TreeNode` instance, including operations on the entire tree

The properties for a `TreeNode` object are very short:
* `parent_node`
* `children_nodes` (an array of TreeNodes)
* `data` (where you store an object, an array, hash, or whatever you would like to contained within a single node)

The methods for a `TreeNode` object cover a variety of needs and functionality

Add / Delete Methods:
```
# create a new node with new_node.data = data_for_new_node AND push new_node into node_object.children_nodes
new_node = node_object.push_child(data_for_new_node)

# delete the first instance found in node_object.children_nodes
new_node = node_object.delete_child(data_for_new_node)
```

Traversal / Movement Methods:
```
node_object.parent_node
node_object.children_nodes

# returns the first node found without a parent_node (the top of the tree)
root_node = node_object.find_root_node
```

Search Methods:
```
node_object.ancestors_contains?(data_to_check)  # returns true / false
node_object.children_contains?(data_to_check)   # returns true / false
node_object.tree_contains?(data_to_check)       # returns true / false
```

Iteration / Execution Methods:
```
# iterate just through node_object's children_nodes, (no sub-children)
node_object.children_nodes.each { |node| puts node.data }

#iterate through ALL nodes in the entire tree
node_object.each_in_tree { |node| puts node.data }

#iterate recursively through all children and sub-children
node_object.each_child_in_tree { |node| puts node.data }
```


Configuration / Option Methods:
```
# only permit unique nodes when calling push_child(), raises NonUniqueNodeError for a non-unique push
node_object.require_unique_nodes(boolean)
```


## Ideas

Great ways to use juniper might include:

* Use reflection on objects to generate a clean tree structure for you
* Identify combinations or series of nodes against certain criteria


## Tests

More to come... potentially MiniTest?


## Contributors

Improving the gem would be great! Please feel free to submit pull requests, suggest improvements or ask questions.

There are a few design goals to keep in mind for those wishing to contribute:

* juniper is to be extremely KISS-oriented: the shorter, the simpler, the better
* keeping the code base simple and general use is preferred over rarely used functionality being merged in
* improving performance by tripling the quantity of code is unacceptable - if performance is your priority, look for gems that have implemented tree structures in C/C++ with bindings.


## License

juniper is licensed under the MIT License.
