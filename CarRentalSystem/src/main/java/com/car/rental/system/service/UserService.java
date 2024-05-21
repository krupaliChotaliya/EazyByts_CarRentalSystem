package com.car.rental.system.service;


import com.car.rental.system.Model.User;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public interface UserService {

    User getlogin(String email, String password);

    User saveUser(User user);

    User getUser(String email);

    List<User> getAllUsers();

    Optional<User> getUserBYUserId(int userId);

    void updateUser(User user, int userId);

}
