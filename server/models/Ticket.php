<?php

class Ticket extends DataStore {
    const TABLE = 'tickets';

    public static function getProps() {
        return array(
            'ticketId',
            'title',
            'content',
            'language',
            'department',
            'file',
            'date',
            'unread',
            'closed',
            'author',
            'owner',
            'ownComments'
        );
    }

    protected function getDefaultProps() {
        return array();
    }
}