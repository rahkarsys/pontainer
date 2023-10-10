version: '3'
services:
  postgres:
    image: postgres:latest
    container_name: postgres
    environment:
      POSTGRES_USER: myuser
      POSTGRES_PASSWORD: mypassword
      POSTGRES_DB: mydatabase
    volumes:
      - postgres_data:/var/lib/postgresql/data
    networks:
      - postgres_network
  pgadmin:
    image: dpage/pgadmin4:latest
    container_name: pgadmin
    environment:
      PGADMIN_DEFAULT_EMAIL: myemail@example.com
      PGADMIN_DEFAULT_PASSWORD: myadminpassword
    ports:
      - "5050:80"
    networks:
      - postgres_network
volumes:
  postgres_data:
networks:
  postgres_network:
