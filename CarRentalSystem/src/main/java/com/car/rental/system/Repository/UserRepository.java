package com.car.rental.system.Repository;


import com.car.rental.system.Model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository extends JpaRepository<User,Integer> {

    @Query(value = "SELECT * FROM users WHERE email = :email AND password = :password", nativeQuery = true)
    User login(String email, String password);

    @Query(value = "SELECT * FROM users WHERE email = :email", nativeQuery = true)
    User getUser(String email);

    @Query(value = "SELECT * FROM users WHERE email = :email AND password = :password and role = :role", nativeQuery = true)
    User IsAdmin(String email, String password,String role);
}
