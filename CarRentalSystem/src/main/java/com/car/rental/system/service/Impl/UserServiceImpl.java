package com.car.rental.system.service.Impl;

import com.car.rental.system.Model.User;
import com.car.rental.system.Repository.UserRepository;
import com.car.rental.system.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserRepository userRepository;

    @Override
    public User getlogin(String email, String password) {
        return userRepository.login(email, password);
    }


    @Override
    public User saveUser(User user) {
        return userRepository.save(user);
    }

    @Override
    public User getUser(String email) {
        return userRepository.getUser(email);
    }

    @Override
    public List<User> getAllUsers() {
        return userRepository.findAll();
    }

    @Override
    public Optional<User> getUserBYUserId(int userId) {
        return userRepository.findById(userId);
    }

    @Override
    public void updateUser(User newUser, int userId) {
        User user = userRepository.findById(userId).orElse(null);
        if (user != null) {
            user.setEmail(newUser.getEmail());
            user.setPassword(newUser.getPassword());
            user.setUsername(newUser.getUsername());
            userRepository.save(newUser);
        }
    }
    
}
