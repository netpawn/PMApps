package com.example.myloyaltycards.model;

import android.content.Context;

import androidx.room.Database;
import androidx.room.Room;
import androidx.room.RoomDatabase;

@Database(entities = {Card.class}, version = 1)
public abstract class CardsDatabase extends RoomDatabase {
    private static CardsDatabase instance;
    private static final String DATABASE_NAME = "cards_database";

    public static CardsDatabase getInstance(Context context) {
        if(instance == null) {
            instance = Room.databaseBuilder(context, CardsDatabase.class, DATABASE_NAME).build();
        }
        return instance;
    }

    public abstract CardDao cardDao();
}
