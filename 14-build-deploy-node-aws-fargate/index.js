const { log } = require("console");
const express = require("express");
const app = express();

app.use(express.json());
app.use(express.urlencoded({extended: true}))
const fs = require("fs"); // reading files and writing

app.post("/todo", (request, response) => {
    if(!request.body.name){
        return response.status(400).json({status: 400, message: "Name field is required"})
    }
  const { name }  = request.body;
  fs.readFile("./stores/todos.json", "utf-8", (err, data) => {
    if (err) {
      return response
        .status(500)
        .json({ status: 500, message: "could not retrieve the list of todos" });
    }
    const todos = JSON.parse(data);

    for( i=0; i < todos.length; i++){
        if(todos[i].name === name){
        return response.status(400).json({status: 400, message: "todo already exists"});
        }
    }
   
    todos.push({id: todos.length+1, name: name, completed: false});
    fs.writeFile('./stores/todos.json', JSON.stringify(todos), () => {
        return response.json({status: 201, message: "todo created successfully"})
    })

  });
});

// reading a file
app.get("/todos", (request, response) => {
    const showPending = request.query.showpending;
  fs.readFile("./stores/todos.json", "utf-8", (err, data) => {
    if (err) {
      return response
        .status(500)
        .json({ status: 500, message: "could not retrieve the list of todos" });
    }
    const todos = JSON.parse(data); // converting string of todos to lists of objects
    if(showPending !=="1") return response.status(200).json(todos);
    return response.json({todos: todos.filter(t => {return t.completed === false})})
  });
});

app.put("/todos/:id/complete", (request, response) => {
  const id = request.params.id;
  const findTodoById = (todos, id) => {
    for(let i=0; i < todos.length; i++){
        if(todos[i].id === parseInt(id)){
            return i
        }
    }
    return -1;
  }

  fs.readFile("./stores/todos.json", "utf-8", (err, data) => {
    if (err) {
      return response
        .status(500)
        .json({ status: 500, message: "could not retrieve the list of todos" });
    }
    const todos = JSON.parse(data);
    const todoIndex = findTodoById(todos, id);
    if(todoIndex === -1) return response.status(404).json({status: 404, message: "Todo not found"})
    
    todos[todoIndex].completed = true;
    fs.writeFile('./stores/todos.json', JSON.stringify(todos), () => {
        return response.json({status: 200, message: "todo completed"})
    })
  });
});

app.delete('/todos/:id', (request, response) => {
    const id = request.params.id;
    const findTodoById = (todos, id) => {
      for(let i=0; i < todos.length; i++){
          if(todos[i].id === parseInt(id)){
              return i
          }
      }
      return -1;
    }
  
    fs.readFile("./stores/todos.json", "utf-8", (err, data) => {
      if (err) {
        return response
          .status(500)
          .json({ status: 500, message: "could not retrieve the list of todos" });
      }
      let todos = JSON.parse(data);
      const todoIndex = findTodoById(todos, id);
      if(todoIndex === -1) return response.status(404).json({status: 404, message: "Todo not found"})
      
      todos = todos.filter(t => t.id !== parseInt(id));
      fs.writeFile('./stores/todos.json', JSON.stringify(todos), () => {
          return response.json({status: 200, message: "todo deleted successfully"})
      })
    });
});

app.listen(3000, () => {
  console.log("Application running on http://localhost:3000");
});
