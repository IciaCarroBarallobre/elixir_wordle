defmodule ElixirWordle.GlobalSetup do
  @moduledoc """
  Module for seeding on Fly.io.
  """
  alias ElixirWordle.Repo
  alias ElixirWordle.Words.Word

  def seed() do
    seed_words()
  end

  def seed_words() do
    ################## Day 1 ##################
    Repo.insert!(
      %Word{}
      |> Word.changeset(%{
        word: "sigil",
        clue: "Sigils are mechanisms for working with textual representations.",
        description: "Sigils are mechanisms for working with textual representations.
      They start with the tilde (~) character which is followed by a letter and then a delimiter.
      Common sigils: ~r, regex expressions; ~c, charlist; ~s, strings; ~w, lists of words;
      ~D, date; ~T, time;"
      })
    )

    Repo.insert!(
      %Word{}
      |> Word.changeset(%{
        word: "kernel",
        clue: "Module that contains basic language primitives and macros.",
        description: "You can invoke Kernel functions and macros anywhere in Elixir code
      without the use of the 'Kernel.' prefix since they have all been automatically imported. "
      })
    )

    Repo.insert!(
      %Word{}
      |> Word.changeset(%{
        word: "atom",
        clue: "Built-in data type: literal constants with a name.",
        description: "For example: 'true', 'false', and 'nil' are atoms."
      })
    )

    Repo.insert!(
      %Word{}
      |> Word.changeset(%{
        word: "function",
        clue: "Built-in data type: a reference to code chunk.",
        description: "Kernel module contains an apply/2, that allow us to invokes
      a given anonymous function with a list of arguments."
      })
    )

    Repo.insert!(
      %Word{}
      |> Word.changeset(%{
        word: "list",
        clue: "Built-in data types: collections of a variable number of elements.",
        description: "Linked lists hold zero, one, or more elements in the chosen order.
      So, in lists the order matters: '[1,2] != [2,1]' "
      })
    )

    Repo.insert!(
      %Word{}
      |> Word.changeset(%{
        word: "process",
        clue: "Built-in data types: light-weight threads of execution.",
        description: "Its module provides low-level conveniences to work with processes,
      developers typically use abstractions such as Agent, GenServer, Registry, Supervisor and Task
      for building their systems and resort to this module for gathering information,
      trapping exits, links and monitoring. "
      })
    )

    Repo.insert!(
      %Word{}
      |> Word.changeset(%{
        word: "port",
        clue: "Built-in data types: mechanisms to interact with the external world.",
        description: "Ports provide a mechanism to start operating system processes
        external to the Erlang VM and communicate with them via message passing."
      })
    )

    Repo.insert!(
      %Word{}
      |> Word.changeset(%{
        word: "tuple",
        clue: "Built-in data types: collections of a fixed number of elements.",
        description: "Tuples are intended as fixed-size containers for multiple elements.
      To manipulate a collection of elements, use a list instead.
      Enum functions do not work on tuples."
      })
    )

    Repo.insert!(
      %Word{}
      |> Word.changeset(%{
        word: "mapset",
        clue: "Data types: unordered collections of unique elements.",
        description: "A set is a data structure that can contain unique elements of any kind,
      without any particular order. MapSet is the 'go to' set data structure in Elixir."
      })
    )

    ################## Day 10 ##################

    Repo.insert!(
      %Word{}
      |> Word.changeset(%{
        word: "string",
        clue: "Data types: UTF-8 encoded binaries representing characters.",
        description: "Strings in Elixir are UTF-8 encoded binaries.
      They are a sequence of Unicode characters, typically written between double quoted strings.
      They also support interpolation, so you can place some value in the middle of
      a string by using the \#{} syntax.
      "
      })
    )

    Repo.insert!(
      %Word{}
      |> Word.changeset(%{
        word: "URI",
        clue: "Data types: representation that identify resources.",
        description:
          "Its module provides functions that allow parsing URIs or encoding query strings."
      })
    )

    Repo.insert!(
      %Word{}
      |> Word.changeset(%{
        word: "regex",
        clue: "Data types: representation that identify resources.",
        description:
          "Its module provides functions that allow parsing URIs or encoding query strings."
      })
    )

    Repo.insert!(
      %Word{}
      |> Word.changeset(%{
        word: "protocol",
        clue:
          "Mechanism to achieve polymorphism when you want behaviour to vary depending on the data type",
        description:
          "Protocols allow us to extend the original behaviour for as many data types as we need.
      That's because dispatching on a protocol is available to any data type that has implemented the
      protocol and a protocol can be implemented by anyone, at any time."
      })
    )

    Repo.insert!(
      %Word{}
      |> Word.changeset(%{
        word: "enum",
        clue: "Protocol that implements List, Map and Range types.",
        description:
          "Enum module functions are eager: they will traverse the enumerable as soon as they are invoked.
      This is particularly dangerous when working with infinite enumerables. In such cases, you should use the Stream
      module, which allows you to lazily express computations, without traversing collections, and work with possibly
      infinite collections."
      })
    )

    Repo.insert!(
      %Word{}
      |> Word.changeset(%{
        word: "server",
        clue:
          "A process that waits for and responds to requests from other processes or clients.",
        description:
          "GenServer facilities this. It's a behaviour module for implementing the server of a client-server relation.
        A GenServer is a process like any other Elixir process and it can be used to keep state,
         execute code asynchronously and so on. The "
      })
    )

    Repo.insert!(
      %Word{}
      |> Word.changeset(%{
        word: "agent",
        clue: "A simple abstraction around state.",
        description:
          "Often in Elixir there is a need to share or store state that must be accessed
       from different processes or by the same process at different points in time.
       In general, Agent is more appropriate than GenServer for simple cases where a single value needs
       to be shared across processes and updated in a coordinated way. GenServer is more appropriate than Agent
       for complex cases where multiple processes need to interact with a shared state and handle various
       types of messages.
       "
      })
    )

    Repo.insert!(
      %Word{}
      |> Word.changeset(%{
        word: "registry",
        clue: " A mechanism in Elixir for storing and looking up processes by name.",
        description:
          "The Elixir Registry is a key-value store that maps process names to PIDs (process IDs).
         It provides a simple way to register processes under a unique name and then easily look
         them up later. It is a local, decentralized and scalable mechanism, meaning that each process
         can have its own registry, and registries can be distributed across multiple nodes in a cluster."
      })
    )

    Repo.insert!(
      %Word{}
      |> Word.changeset(%{
        word: "task",
        clue:
          "A lightweight abstraction that simplifies the execution of asynchronous or background tasks.",
        description:
          " In Elixir, a Task is a lightweight process that is designed to execute a specific action throughout
         its lifetime. Tasks are often used to perform background or asynchronous work, such as sending emails,
         processing images, or performing database migrations. Tasks can be supervised, and they provide a simple
         way to spawn a process and wait for its result."
      })
    )

    Repo.insert!(
      %Word{}
      |> Word.changeset(%{
        word: "guard",
        clue: "A way to augment pattern matching with more complex checks",
        description:
          "Not all expressions are allowed in guard clauses, but only a handful of them.
       This is a deliberate choice. This way, Elixir (and Erlang) can make sure that nothing bad happens
       while executing guards and no mutations happen anywhere. It also allows the compiler to optimize
       the code related to guards efficiently."
      })
    )

    Repo.insert!(
      %Word{}
      |> Word.changeset(%{
        word: "path",
        clue: "Module provides conveniences for manipulating or retrieving file system routes.",
        description:
          "The Path module provides functions for working with file system paths in a cross-platform way.
         It provides functions for joining and splitting paths, checking whether a path exists, getting
         information about a path, and more."
      })
    )

    ################## Day 20 ##################

    Repo.insert!(
      %Word{}
      |> Word.changeset(%{
        word: "callback",
        clue:
          "An Elixir module attribute used to define a required function signature for a behaviour implementation.",
        description:
          "The @callback module attribute is a powerful tool in Elixir for defining required
        function signatures for a module to implement. When used in conjunction with behaviours,
        it allows developers to enforce the implementation of certain functions across multiple modules,
         ensuring a consistent and predictable API. By specifying the required signature of the function,
         it also helps to document the expected inputs and outputs, making it easier for developers to use
          and understand the code."
      })
    )

    Repo.insert!(
      %Word{}
      |> Word.changeset(%{
        word: "erlang",
        clue: "Functional programming language used for building distributed systems",
        description:
          "Erlang is a programming language designed for building distributed, fault-tolerant systems
        with soft real-time properties."
      })
    )

    Repo.insert!(
      %Word{}
      |> Word.changeset(%{
        word: "elixir",
        clue:
          "Dynamic, functional programming language designed for building scalable and maintainable applications",
        description:
          "Elixir is a dynamic, functional programming language designed for building scalable and
         maintainable applications."
      })
    )

    Repo.insert!(
      %Word{}
      |> Word.changeset(%{
        word: "iex",
        clue: "Elixir's interactive shell.",
        description: "Inside IEx, hitting Ctrl+C will open up the BREAK menu.
        In this menu you can quit the shell,
        see process and ETS tables information and much more."
      })
    )

    Repo.insert!(
      %Word{}
      |> Word.changeset(%{
        word: "eex",
        clue: "It stands for Embedded Elixir.",
        description:
          "Embedded Elixir allows you to embed Elixir code inside a string in a robust way."
      })
    )

    Repo.insert!(
      %Word{}
      |> Word.changeset(%{
        word: "logger",
        clue: "Log library for Elixir applications.",
        description: "It includes many features, providing, info, warn and error levels."
      })
    )

    Repo.insert!(
      %Word{}
      |> Word.changeset(%{
        word: "mix",
        clue: "A build tool for creating, compiling, and testing Elixir applications.",
        description: "Mix is a command-line tool that comes bundled with Elixir,
        and is used for creating, compiling, and testing Elixir applications.
        It provides a set of tasks that can be used to manage an Elixir project,
         such as creating a new project, running tests, and generating documentation."
      })
    )

    Repo.insert!(
      %Word{}
      |> Word.changeset(%{
        word: "boolean",
        clue: "A data type that can have one of two possible values: true or false.",
        description: "In Elixir, boolean is a data type that can hold one of two possible values:
       true or false. It is often used in conditional expressions and logical operations,
       such as if statements, and/or expressions, and pattern matching."
      })
    )

    Repo.insert!(
      %Word{}
      |> Word.changeset(%{
        word: "case",
        clue: "A control flow construct used for pattern matching.",
        description: "It is a control flow construct in Elixir that is used for pattern matching.
      It allows you to match a value against a set of patterns, and execute different
      code depending on which pattern matches. It is often used in conjunction with
      pattern matching operators like = and ->."
      })
    )

    Repo.insert!(
      %Word{}
      |> Word.changeset(%{
        word: "cond",
        clue: "A control flow construct used for testing multiple conditions.",
        description: "It is another control flow construct in Elixir that is used
      for testing multiple conditions. It works by evaluating a series
      of expressions in order, and executing the code associated with the
      first expression that evaluates to true. It is often used in cases where
       you need to test multiple conditions that are not easily expressed using
       a single if statement."
      })
    )

    ################# WORD 30

    Repo.insert!(
      %Word{}
      |> Word.changeset(%{
        word: "binaries",
        clue: "A data type for working with sequences of bytes.",
        description: "In Elixir, binaries is a data type that is used for
      working with sequences of bytes. It is similar to a string,
      but is more efficient for handling large amounts of binary data,
      such as images, audio files, or network packets. Elixir provides
      a set of functions for working with binaries, such as <<>> for
      constructing binary data, String.to_integer for converting binary data to integers,
      and :crypto.hash for computing cryptographic hashes of binary data."
      })
    )

    Repo.insert!(
      %Word{}
      |> Word.changeset(%{
        word: "alias",
        clue: "A keyword used for creating short names for modules.",
        description:
          "In Elixir, alias is a keyword that is used for creating short names for modules.
       It allows you to refer to a module by a shorter name, rather than its full name,
       which can be useful for reducing typing and improving readability.
       For example, you could use alias MyModule.Database to refer to MyModule.Database as simply Database."
      })
    )

    Repo.insert!(
      %Word{}
      |> Word.changeset(%{
        word: "require",
        clue: "A keyword used for loading modules at compile time.",
        description: "It is another keyword in Elixir that is used for loading modules,
        but it is typically used at compile time, rather than at runtime.
        It allows you to specify a list of modules that your code depends on,
         and ensures that those modules are loaded and available during compilation.
         This can be useful for resolving dependencies and detecting errors early in
         the development process."
      })
    )

    Repo.insert!(
      %Word{}
      |> Word.changeset(%{
        word: "import",
        clue:
          "Keyword used to bring functions and macros from a module into the current context.",
        description:
          "It can be used to avoid having to prepend the module name to each function call
        or to alias module names for clarity."
      })
    )

    Repo.insert!(
      %Word{}
      |> Word.changeset(%{
        word: "use",
        clue: "Elixir keyword that injects code from a given module into the current context.",
        description:
          "It's often used to provide a set of functions that can be used across multiple modules."
      })
    )

    Repo.insert!(
      %Word{}
      |> Word.changeset(%{
        word: "module",
        clue: "A construct in Elixir that groups related functions and data under a common name.",
        description:
          "It can be used to organize code and to define behavior through the implementation of protocols."
      })
    )

    Repo.insert!(
      %Word{}
      |> Word.changeset(%{
        word: "exit",
        clue: "A signal in Elixir that can be sent to a process to terminate it.",
        description: "It can be used to gracefully shut down a process or to handle errors."
      })
    )

    Repo.insert!(
      %Word{}
      |> Word.changeset(%{
        word: "catch",
        clue: "A construct in Elixir that allows the program to recover from errors.",
        description: "It can be used to handle errors without crashing the program, similar to
        a try-catch block in other languages."
      })
    )

    Repo.insert!(
      %Word{}
      |> Word.changeset(%{
        word: "crypto",
        clue: "Elixir module that provides functions for cryptographic operations.",
        description:
          "It includes hashing, encryption, and decryption functions, as well as support
        for public key cryptography."
      })
    )

    Repo.insert!(
      %Word{}
      |> Word.changeset(%{
        word: "ets",
        clue: "Erlang Term Storage, a data structure in Elixir that provides a high-performance,
        in-memory key-value store.",
        description: "It can be used to store and retrieve large amounts of data quickly,
        but is not persisted to disk."
      })
    )

    ########### DAY 40

    Repo.insert!(
      %Word{}
      |> Word.changeset(%{
        word: "queue",
        clue: "A data structure in Elixir that follows a first-in-first-out (FIFO) ordering.",
        description:
          "It can be used to manage the order of operations or to handle a sequence of events."
      })
    )

    Repo.insert!(
      %Word{}
      |> Word.changeset(%{
        word: "rand",
        clue: "Elixir module that provides functions for generating random numbers.",
        description: "It includes functions for generating integers, floats, and booleans
        with different distributions."
      })
    )

    Repo.insert!(
      %Word{}
      |> Word.changeset(%{
        word: "zlib",
        clue: "Elixir module that provides functions for compressing and decompressing data.",
        description:
          "It can be used to reduce the size of data for more efficient storage or transmission."
      })
    )

    Repo.insert!(
      %Word{}
      |> Word.changeset(%{
        word: "streams",
        clue: "A data processing concept in Elixir that allows for lazy, efficient
      processing of data.",
        description: "It can be used to process large data sets or infinite data streams
         without having to load all the data into memory at once."
      })
    )

    Repo.insert!(
      %Word{}
      |> Word.changeset(%{
        word: "pipe",
        clue:
          "A macro that helps to compose functions and data in a more readable and functional way.",
        description: "It passes the output of one function as input to another function,
        allowing to chain functions together into a pipeline."
      })
    )

    Repo.insert!(
      %Word{}
      |> Word.changeset(%{
        word: "math",
        clue: "A built-in module that provides math-related functions.",
        description:
          "It offers a wide range of mathematical operations that can be used in Elixir applications."
      })
    )

    Repo.insert!(
      %Word{}
      |> Word.changeset(%{
        word: "dbg",
        clue: " It provides a way to set trace points in code for debugging purposes.",
        description: "It allows developers to inspect and debug code at runtime by
        setting breakpoints and examining the state of the system."
      })
    )

    Repo.insert!(
      %Word{}
      |> Word.changeset(%{
        word: "inspect",
        clue: "Function at IO module that is commonly used for debugging and testing purposes.",
        description: " It offers a convenient way to inspect and print data structures
        such as maps, lists, and tuples."
      })
    )

    Repo.insert!(
      %Word{}
      |> Word.changeset(%{
        word: "debugger",
        clue:
          "A tool that provides a graphical user interface for debugging Elixir applications.",
        description: "It allows developers to set breakpoints, inspect the call stack,
        and evaluate expressions at runtime."
      })
    )

    Repo.insert!(
      %Word{}
      |> Word.changeset(%{
        word: "observer",
        clue: "It allows you to inspect the system metrics of the application.",
        description: " It provides information on system resources such as CPU and memory usage,
        process information, and message statistics."
      })
    )

    ############### DAY 50

    Repo.insert!(
      %Word{}
      |> Word.changeset(%{
        word: "typespec",
        clue: "It is used for type checking and documentation purposes.",
        description:
          "It helps to catch errors early by ensuring that functions are called with the
         correct arguments and can also be used for generating documentation."
      })
    )

    Repo.insert!(
      %Word{}
      |> Word.changeset(%{
        word: "quote",
        clue: "It is often used in macros to generate code dynamically.",
        description:
          " It converts Elixir code into an abstract syntax tree that can be manipulated
        and transformed at compile-time."
      })
    )

    Repo.insert!(
      %Word{}
      |> Word.changeset(%{
        word: "unquote",
        clue:
          "A macro that allows you to evaluate a variable or expression in the current context.",
        description:
          "It  is an Elixir macro that allows you to insert the value of a variable or
        expression into the current context during macro expansion. This is useful when
         you want to generate code that depends on the value of a variable or expression at runtime."
      })
    )

    Repo.insert!(
      %Word{}
      |> Word.changeset(%{
        word: "macros",
        clue: "Code that generates code.",
        description:
          "Macros are a powerful feature of Elixir that allow you to write code that generates other
         code at compile-time. Macros can be used to simplify complex or repetitive code, enforce
         coding conventions, and enable domain-specific languages within Elixir."
      })
    )

    Repo.insert!(
      %Word{}
      |> Word.changeset(%{
        word: "doctest",
        clue: "A tool for running tests in documentation.",
        description:
          "It  is a testing tool built into Elixir that allows you to write tests in your documentation.
        It runs the code examples in your documentation as tests and reports any errors or failures.
        This can help ensure that your documentation stays up-to-date and accurate."
      })
    )

    Repo.insert!(
      %Word{}
      |> Word.changeset(%{
        word: "gentcp",
        clue: "A library for generating TCP clients and servers.",
        description:
          "It is a library for Elixir that allows you to easily generate TCP clients and servers.
        It provides a simple API for setting up TCP connections, sending and receiving data,
        and handling errors."
      })
    )

    Repo.insert!(
      %Word{}
      |> Word.changeset(%{
        word: "deps",
        clue: "Mix function for managing external libraries.",
        description: "It is a command-line tool built into Elixir for managing external
        libraries and dependencies. It allows you to easily add, remove,
        and update libraries from a central repository, and helps ensure that
         your project's dependencies are up-to-date and compatible."
      })
    )

    Repo.insert!(
      %Word{}
      |> Word.changeset(%{
        word: "exunit",
        clue: "Elixir's built-in unit testing framework.",
        description: "It is Elixir's built-in unit testing framework. It provides a simple
         and intuitive syntax for writing tests, along with powerful assertions
         and test fixtures. It is widely used in the Elixir community for testing
         Elixir code."
      })
    )

    Repo.insert!(
      %Word{}
      |> Word.changeset(%{
        word: "otp",
        clue: "A framework for building fault-tolerant distributed systems",
        description: "It is a framework for building fault-tolerant distributed systems in Elixir.
        It provides a set of libraries and tools for building highly scalable and resilient
        applications, including support for process supervision, message passing, and error
        handling."
      })
    )

    Repo.insert!(
      %Word{}
      |> Word.changeset(%{
        word: "env",
        clue: "Mix used for configuring applications.",
        description: "It is a configuration feature of Elixir's build tool mix.
        It allows you to define environment-specific settings for your application,
         such as database credentials or API keys. These settings can be loaded
          at runtime and used to configure your application."
      })
    )

    ################### Day 60 ##################

    Repo.insert!(
      %Word{}
      |> Word.changeset(%{
        word: "format",
        clue: "Mix command to organize the structure, the spaces, etc, of given files.",
        description: "It takes a format string as the first argument, followed by any additional
        arguments that are used to fill in the placeholders in the format string."
      })
    )

    Repo.insert!(
      %Word{}
      |> Word.changeset(%{
        word: "umbrella",
        clue:
          "A project structure that allows you to manage multiple Elixir applications together.",
        description:
          "An umbrella project contains multiple child applications, which can share code and
        dependencies with each other."
      })
    )

    Repo.insert!(
      %Word{}
      |> Word.changeset(%{
        word: "phoenix",
        clue: "Web Framework",
        description:
          "Phoenix is a web framework for Elixir that aims to provide a productive and fault-tolerant
        web application development experience"
      })
    )

    Repo.insert!(
      %Word{}
      |> Word.changeset(%{
        word: "plug",
        clue: "Web Middleware",
        description:
          "Plug is a composable web middleware for Elixir, used for building web applications,
        focusing on composability, minimalism, and ease of use."
      })
    )

    Repo.insert!(
      %Word{}
      |> Word.changeset(%{
        word: "cowboy",
        clue: "HTTP Server",
        description: "Cowboy is a small, fast, and modern HTTP server for Erlang and Elixir,
        designed for high-performance applications."
      })
    )

    Repo.insert!(
      %Word{}
      |> Word.changeset(%{
        word: "channel",
        clue: "Real-time Communication",
        description: "Channels are a real-time communication abstraction in Phoenix, allowing for
         bidirectional communication between the client and server over WebSockets."
      })
    )

    Repo.insert!(
      %Word{}
      |> Word.changeset(%{
        word: "livebook",
        clue: "Interactive Notebooks",
        description: "Livebook is a web-based interactive notebook for Elixir, used for exploring,
        learning, and sharing Elixir code and documentation in a collaborative
        and interactive environment."
      })
    )

    Repo.insert!(
      %Word{}
      |> Word.changeset(%{
        word: "builtin",
        clue: "Functions or modules that are included in the language's core distribution.",
        description:
          "Some examples of built-in modules in Elixir include Enum, List, Map, IO, and Kernel."
      })
    )

    Repo.insert!(
      %Word{}
      |> Word.changeset(%{
        word: "reduce",
        clue: "A higher-order function in Elixir to transform an enum into another value,
      by applying a given function to each element of the list and accumulating the result.",
        description: "It is a powerful and flexible function that can help you write
        concise and efficient Elixir code for a wide variety of use cases.
        A useful feature of Enum.reduce is that it can be used with lazy enumerables,
        such as streams, to process potentially infinite data sets in a memory-efficient way.
        By processing the data one element at a time and accumulating the result as you go, you
        can avoid the need to load the entire data set into memory at once.
         "
      })
    )

    Repo.insert!(
      %Word{}
      |> Word.changeset(%{
        word: "exs",
        clue: "Elixir Script files extension.",
        description: "Exs files are Elixir Script files, which are used to write Elixir code that
        can be compiled and run as scripts."
      })
    )

    ################### Day 70 ##################

    Repo.insert!(
      %Word{}
      |> Word.changeset(%{
        word: "tailwind",
        clue: "Utility-first CSS framework integrated in phoenix +1.7",
        description: "Tailwind CSS is a utility-first CSS framework that allows you to quickly and
        easily create custom designs without having to write your own CSS from scratch."
      })
    )

    Repo.insert!(
      %Word{}
      |> Word.changeset(%{
        word: "ecto",
        clue: "A database wrapper and query generator for Elixir.",
        description: "Ecto is a powerful database wrapper and query generator for Elixir.
       It provides a simple and intuitive way to interact with databases,
       including support for various database backends, data migrations,
       query composition, and more. With Ecto, developers can easily build
       and maintain robust, scalable database applications."
      })
    )

    Repo.insert!(
      %Word{}
      |> Word.changeset(%{
        word: "seeding",
        clue:
          "The process of populating a database with initial data for development or testing purposes.",
        description:
          "Seeding refers to the process of initializing a database with data that will be used
       for development or testing purposes. This data can include default values, test data, or any other
       data that is needed to properly test and develop a system. Seeding can be done manually,
       or automated using tools or scripts, and is an important step in ensuring the quality and reliability
       of a database-driven application."
      })
    )

    Repo.insert!(
      %Word{}
      |> Word.changeset(%{
        word: "liveview",
        clue:
          "A server-side rendering mechanism that allows developers to create reactive, real-time user
         interfaces using Phoenix.",
        description:
          "It is a library for the Phoenix web framework that enables developers to create dynamic,
        real-time user interfaces using server-side rendering. With LiveView, developers can write reactive,
        interactive applications in a declarative and maintainable way, without having to write JavaScript
        or rely on client-side frameworks. LiveView uses WebSockets to maintain a persistent connection between
         the client and server, allowing changes made on the server to be immediately reflected on the client,
         without requiring a page refresh."
      })
    )

    Repo.insert!(
      %Word{}
      |> Word.changeset(%{
        word: "pubsub",
        clue: "A messaging system for distributed systems, allowing different parts of a system
        to communicate with each other in a loosely coupled manner.",
        description: "PubSub is a common abbreviation for 'publish-subscribe', which refers to a
       messaging pattern used in distributed systems. In Elixir, the pubsub module is part of
        the Phoenix framework and provides an implementation of this pattern. With pubsub,
        different parts of a system can communicate with each other in a loosely coupled manner,
        where publishers send messages to a channel and subscribers receive those messages without
        being aware of each other's existence. This allows for more flexible and scalable architectures,
        as components can be added or removed without affecting the rest of the system.
        The pubsub module provides an easy-to-use API for setting up channels and
        subscribing/publishing messages."
      })
    )

    Repo.insert!(
      %Word{}
      |> Word.changeset(%{
        word: "oban",
        clue:
          "A job processing library for Elixir and Phoenix, providing a simple and reliable way
        to process background jobs.",
        description:
          "Oban is a job processing library for Elixir and Phoenix, designed to handle long-running or
       recurring tasks that need to be performed in the background. With Oban, you can define jobs
       as simple Elixir modules and enqueue them for later processing, specifying priorities, timeouts,
       and other job-specific parameters. Oban also provides a robust monitoring and management interface,
        allowing you to track the progress of your jobs, detect and recover from errors, and configure
        various aspects of the processing pipeline. Whether you need to send emails, update search indexes,
         process payments, or perform any other type of background task, Oban can help you do it efficiently
          and reliably."
      })
    )

    Repo.insert!(
      %Word{}
      |> Word.changeset(%{
        word: "swoosh",
        clue: "A library for sending emails in Elixir and Phoenix, with support for various email
        providers and templating engines.",
        description:
          "With swoosh, you can easily send emails from your Elixir or Phoenix application, using a range of
         popular email providers and templates. Need to send transactional emails or newsletters from your
          Elixir app? Swoosh can help you streamline the process, with built-in support for common email
          providers like SendGrid and Mailgun."
      })
    )

    Repo.insert!(
      %Word{}
      |> Word.changeset(%{
        word: "benchee",
        clue:
          "A benchmarking library, providing a simple and flexible way to measure the performance of code.",
        description:
          "Some of the benefits of using Benchee include its simplicity, flexibility, and ease of use,
        as well as its ability to run benchmarks in parallel and support for measuring memory usage and
         garbage collection. Overall, it is a powerful tool for optimizing and fine-tuning Elixir applications,
          particularly when it comes to performance-critical code."
      })
    )

    Repo.insert!(
      %Word{}
      |> Word.changeset(%{
        word: "schema",
        clue: "A data validation and normalization library for Elixir, allowing developers
        to ensure that data conforms to a specific format.",
        description:
          "Schemas are a fundamental concept in Elixir and are used to ensure that data conforms to a specific format.
         Schemas can be used to validate data and normalize it to a specific format. They are often used in
         conjunction with Ecto, which is a powerful database wrapper and query generator for Elixir. With Ecto,
          developers can create and maintain database schemas and use them to perform database operations.
          Schemas are also useful in other areas of Elixir development, such as building APIs or web applications,
           where data validation and normalization are important."
      })
    )

    Repo.insert!(
      %Word{}
      |> Word.changeset(%{
        word: "context",
        clue: "A concept in Phoenix that refers to a grouping of related functionality and data,
        used to organize code and manage dependencies.",
        description:
          " A context is typically defined as a module that contains a set of functions for
        a specific domain, such as a blog or an e-commerce site."
      })
    )

    ################### Day 80 ##################

    Repo.insert!(
      %Word{}
      |> Word.changeset(%{
        word: "pipeline",
        clue: "A series of functions that transform data in Elixir.",
        description:
          "A way to compose functions into a single unit of execution that can be used in a
         variety of contexts, such as processing incoming requests in Phoenix or performing
         data transformations in Elixir."
      })
    )

    Repo.insert!(
      %Word{}
      |> Word.changeset(%{
        word: "validate",
        clue: "A function in Ecto.Changeset that runs a validation on the changeset.",
        description: "In Elixir's Ecto library, a changeset is a data structure that
      represents the changes that should be applied to a database entity.
      It includes the original entity data and the changes that should be applied to it.
      A changeset can be used for validation, coercion, and other data transformations before
       the changes are applied to the database"
      })
    )

    Repo.insert!(
      %Word{}
      |> Word.changeset(%{
        word: "query",
        clue: "A request for data from a database.",
        description:
          "A way to retrieve data from a database using Ecto's query DSL, which allows for
        complex queries with conditions, ordering, and grouping."
      })
    )

    Repo.insert!(
      %Word{}
      |> Word.changeset(%{
        word: "repo",
        clue: "The Ecto component responsible for interacting with the database.",
        description:
          "A module that provides a higher-level API for performing CRUD operations on the database
        using Ecto's query DSL."
      })
    )

    Repo.insert!(
      %Word{}
      |> Word.changeset(%{
        word: "date",
        clue: "A data type that represents a calendar period.",
        description:
          "A module that provides functions for working with calendar dates in Elixir, including
        parsing and formatting dates, and performing calculations such as finding the difference
        between two dates."
      })
    )

    Repo.insert!(
      %Word{}
      |> Word.changeset(%{
        word: "charlist",
        clue: "A list of characters.",
        description:
          "A data type that represents a list of characters in Elixir, which is similar to a
        string but can be more efficient in certain situations."
      })
    )

    Repo.insert!(
      %Word{}
      |> Word.changeset(%{
        word: "map",
        clue: "A collection of key-value pairs.",
        description:
          "A data type that represents a collection of key-value pairs in Elixir, which is
        used to store and retrieve values by their keys."
      })
    )

    Repo.insert!(
      %Word{}
      |> Word.changeset(%{
        word: "random",
        clue: "A module for generating arbitrary numbers and values.",
        description:
          "A module that provides functions for generating random numbers and values in Elixir,
        including integers, floats, booleans, and strings."
      })
    )

    Repo.insert!(
      %Word{}
      |> Word.changeset(%{
        word: "zip",
        clue: "A function for combining multiple lists into a single list of tuples.",
        description:
          "A function that takes multiple lists and combines them into a single list of tuples,
        where each tuple contains the corresponding elements from each list."
      })
    )

    Repo.insert!(
      %Word{}
      |> Word.changeset(%{
        word: "BEAM",
        clue: "Virtual machine name that executes the Elixir code compiled to bytecode.",
        description: "BEAM processes are like OS threads in their purpose but are even lighter
       and more efficient. They are employed from OS threads. "
      })
    )

    ################### Day 90 ##################

    Repo.insert!(
      %Word{}
      |> Word.changeset(%{
        word: "gettext",
        clue: "Library used for internationalization (i18n) and localization (l10n) of software
        included at +1.7.",
        description:
          "Gettext is a widely-used library that provides a framework for creating multilingual
        software applications. It allows developers to easily translate user interface text,
        messages, and other content into multiple languages, making it easier for people all
        over the world to use the same software."
      })
    )
  end
end
