public  void startCountdown(int duration) {
    countdownDuration = duration;
    startTime = System.currentTimeMillis();
}

// Function to get the remaining time in seconds
public  int getRemainingTime() {
    long currentTime = System.currentTimeMillis();
    long elapsedTime = (currentTime - startTime) / 1000; // Convert milliseconds to seconds
    remainingTime = countdownDuration - (int)elapsedTime;
    
    // Ensure remaining time is not negative
    return remainingTime > 0 ? remainingTime : 0;
}

// Function to check if the countdown is complete
public  boolean isTimeUp() {
    return getRemainingTime() == 0;
}
