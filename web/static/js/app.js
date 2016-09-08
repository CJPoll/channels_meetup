// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

import socket from "./socket"

window.removeTodo = function(id) {
    const li = document.getElementById("todo-id-" + id);
    li.remove();
}

window.completeTodo = function(e) {
  const id = e.target.dataset.todoId;

  channel.push("todo:complete", {todo_id: id});
}

window.insertTodo = function(createdTodo) {
  const completed = createdTodo.completed;
  const name = createdTodo.name;
  const id = createdTodo.id;

  const todo = new Todo(name, id, completed);
  const li = todo.toHTML();

  todos.appendChild(li);
}

window.Todo = function(name, id, completed) {
  this.name = name;
  this.id = id;
  this.completed = completed || false;
}

Todo.prototype.toHTML = function() {
  const li = document.createElement("li");
  const checkbox = document.createElement("input");
  const label = document.createElement("label");

  checkbox.type = "checkbox";
  checkbox.checked = this.completed;
  checkbox.addEventListener("click", completeTodo);
  checkbox.dataset.todoId = this.id;

  label.innerHTML = this.name;

  li.appendChild(checkbox);
  li.appendChild(label);
  li.id = "todo-id-" + this.id;

  return li;
}

document.getElementById("create-todo").addEventListener("click", () => {
  const textField = document.getElementById("new-todo-name");
  name = textField.value;
  const todo = new Todo(name);
  createTodo(todo);
  textField.value = "";
}, false);

const checkboxes = document.getElementsByClassName("todo-checkbox");

for (let i = 0; i < checkboxes.length; i++) {
  let checkbox = checkboxes[i];
  checkbox.addEventListener("click", completeTodo)
}

let channel = socket.channel("todos:lobby", {})

channel.join()
  .receive("ok", resp => { console.log("Joined successfully", resp) })
  .receive("error", resp => { console.log("Unable to join", resp) })

channel.on("todo:completed", (payload) => {
  console.log("Completed");
  removeTodo(payload.todoId)
})

channel.on("todo:created", insertTodo);

let todos = document.getElementById("todos");

window.createTodo = function(todo) {
  console.log(todo);
  console.log({todo: todo})
  channel.push("todo:create", {todo: todo})
  .receive("ok", (createdTodo) => {
  })
}
