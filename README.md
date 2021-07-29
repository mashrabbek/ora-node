## Documentation

1. `docker login -u <hub-user> -p <hub-password>`
1. `docker build -t <hub-user>/<repo-name>[:<tag>]`
1. `docker tag <existing-image> <hub-user>/<repo-name>[:<tag>]`
1. `docker commit <existing-container> <hub-user>/<repo-name>[:<tag>]`
1. `docker push <hub-user>/<repo-name>:<tag>`
