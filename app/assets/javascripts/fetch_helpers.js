// onclick="send_like(<%= post.id %>)"

function send_like(id) {
  console.log('hi', id)
  fetch(`/posts/${id}/like`, { method: 'POST' })
    .then(res => res.json())
    .then(res => {
      const { success, error } = res
      if (success) {
        const el_likes_count = document.querySelector(`#likes_count_${id}`)
        el_likes_count.innerText = success
      }
      else if (error) {
        console.log(error)
      }
    })
}