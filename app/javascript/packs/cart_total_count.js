
document.addEventListener("turbolinks:load", () => {
  cart_table = document.querySelector(".cart_table")
  if (!cart_table) return

  console.log(cart_table)
  cart_table.addEventListener("click", function({target}){
    if (target.parentNode.className == "item_amount") {
      document.querySelector(".total").textContent = cart_sum()
    }
  })

  function cart_sum() {
    let sum = 0
    Array.from(cart_table.querySelector("tbody").querySelectorAll("tr")).map(function(tr){
      sum += Number(tr.childNodes[2].textContent) * Number(tr.childNodes[3].firstChild.value)
    })
    return sum
  }
})
